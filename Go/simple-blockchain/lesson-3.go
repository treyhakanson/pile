package main

import (
   "os"
   "fmt"
   "flag"
   "bytes"
   "crypto/sha256"
   "strconv"
   "time"
   "math"
   "math/big"
   "encoding/gob"

   "github.com/boltdb/bolt"
)

// NOTE: any `_` in the program are for errors.

/*
#############################################################################
BEGIN CODE FROM LESSON 2
#############################################################################

EDITS:
--------------------------------------------------------------------------------

`NewBlockChain` now retrieves/persists data from the BoltDB

`BlockChain` now just holds a reference to the DB and the tip of the chain; it
no longer holds the entire chain as a slice of blocks.

*/

// More bits, more difficult
const targetBits = 24

// Prevents nonce (counter) overflow when computing a hash. Technically, the
// difficulty of hashing here is too low to overflow, but this is done as a
// best practice
const maxNonce = math.MaxInt64

type Block struct {
   Timestamp     int64
   Data          []byte
   PrevBlockHash []byte
   Hash          []byte
   Nonce         int
}

func NewBlock(data string, prevBlockHash []byte) *Block {
   block := &Block{time.Now().Unix(), []byte(data), prevBlockHash, []byte{}, 0}
   pow := NewProofOfWork(block)
   nonce, hash := pow.Run()

   block.Hash = hash[:]
   block.Nonce = nonce

   return block;
}

func NewGenesisBlock() *Block {
   return NewBlock("Genesis Block", []byte{})
}

type BlockChain struct {
   tip []byte
   db  *bolt.DB
}

func (bc *BlockChain) AddBlock(data string) {
   var lastHash []byte

   // using `View` instead of `Update` because this is a read-only transaction
   // NOTE: why does this need to be done? Why can't `bc.tip` just be used?
   _ = bc.db.View(func(tx *bolt.Tx) error {
      b := tx.Bucket([]byte(blocksBucket))
      lastHash = b.Get([]byte("l"))

      return nil
   })

   newBlock := NewBlock(data, lastHash)

   _ = bc.db.Update(func(tx *bolt.Tx) error {
      b := tx.Bucket([]byte(blocksBucket))

      _ = b.Put(newBlock.Hash, newBlock.Serialize())
      _ = b.Put([]byte("l"), newBlock.Hash)

      bc.tip = newBlock.Hash

      return nil
   })
}

// should handle errors, not included for brevity
func NewBlockChain() *BlockChain {
   var tip []byte

   // attempt to open the database file; it will be created if it doesn't exist.
   // `0600` is the OS file mode, and the final argument is database options.
   db, _ := bolt.Open(dbFile, 0600, nil)

   // attempt to perform an update within a transaction. There are 2 types of
   // transactions in bolt, read-only and read-write. We are using `Update` here
   // because this is a read-write, since we may need to add the Genesis block.
   _ = db.Update(func(tx *bolt.Tx) error {
      // get the bucket containing the blocks from the database
      b := tx.Bucket([]byte(blocksBucket))

      if b == nil { // if the bucket does NOT exist...
         genesis := NewGenesisBlock() // generate the genesis block
         b, _ = tx.CreateBucket([]byte(blocksBucket)) // create the blocks bucket
         _ = b.Put(genesis.Hash, genesis.Serialize()) // insert the genesis block
         _ = b.Put([]byte("l"), genesis.Hash)  // set the l key to the genesis block
         tip = genesis.Hash // update the tip
      } else { // if the bucket doest exist...
         tip = b.Get([]byte("l")) // set the tip equal to the hash of the most recently added block
      }

      return nil
	})

	bc := BlockChain{tip, db}

	return &bc
}

func IntToHex(n int64) []byte {
   return []byte(strconv.FormatInt(n, 16))
}

type ProofOfWork struct {
   block  *Block
   target *big.Int
}

func (pow *ProofOfWork) prepareData(nonce int) []byte {
   data := bytes.Join(
      [][]byte{
         pow.block.PrevBlockHash,
         pow.block.Data,
         IntToHex(pow.block.Timestamp),
         IntToHex(int64(targetBits)),
         IntToHex(int64(nonce)),
      },
      []byte{},
   )

   return data
}

func NewProofOfWork(block *Block) *ProofOfWork {
   target := big.NewInt(1)
   target.Lsh(target, uint(256 - targetBits))

   pow := &ProofOfWork{block, target}

   return pow
}

func (pow *ProofOfWork) Run() (int, []byte) {
   var hashInt big.Int
   var hash [32]byte
   nonce := 0

   fmt.Printf("Mining the block containing \"%s\"\n", pow.block.Data)

   for nonce < maxNonce {
      data := pow.prepareData(nonce)
      hash = sha256.Sum256(data)

      fmt.Printf("\r%x", hash)

      hashInt.SetBytes(hash[:])

      if hashInt.Cmp(pow.target) == -1 {
         break
      } else {
         nonce++
      }
   }

   fmt.Print("\n\n")

   return nonce, hash[:]
}

func (pow *ProofOfWork) Validate() bool {
   var hashInt big.Int

   data := pow.prepareData(pow.block.Nonce)
   hash := sha256.Sum256(data)
   hashInt.SetBytes(hash[:])

   isValid := hashInt.Cmp(pow.target) == -1

   return isValid
}
// #############################################################################
// END CODE FROM LESSON 2
// #############################################################################

/*
Persistant Storage
--------------------------------------------------------------------------------

Obviously, the blockchain must be stored in some DB in order to be reuseable.
The original Bitcoin implementation utilized [LevelDB](https://github.com/google/leveldb),
a key-value store, and this project utilizes a similar DB in [BoltDB](https://github.com/boltdb/bolt),
which is also a key-value store, but is implemented purely in Go.

[Bitcoin Core](https://en.bitcoin.it/wiki/Bitcoin_Core_0.11_(ch_2):_Data_Storage)
uses two buckets to store data:
1. *blocks* stores metadata describing all blocks stored in the block chain
2. *chainstore* stores the state of the chain, which is all currently unspent
transaction outputs and some metadata

Also in Bitcoin Core, blocks are stored in multiple files on the disk. This is
done for a performance purpose: reading a single block won’t require loading all
of them into memory. This will not be implemented here; the entire db will be
represented as a single file.

In *blocks*, the key-value pairs are:
1. 'b' + 32-byte block hash: block index record
2. 'f' + 4-byte file number: file information record
3. 'l': 4-byte file number (the last block file number used)
4. 'R': 1-byte boolean (whether we're in the process of reindexing)
5. 'F' + 1-byte flag name length + flag name string: 1 byte boolean (various
   flags that can be on or off)
6. 't' + 32-byte transaction hash: transaction index record

In *chainstate* the key-value pairs are:
1. 'c' + 32-byte transaction hash: unspent transaction output record for that
   transaction
2. 'B': 32-byte block hash (the block hash up to which the database represents
   the unspent transaction outputs)

Since our blocks are not stored in multiple files, we will not need any of the
keys related to the file number, so this implementation will only have the
following key-value pairs:

1. 32-byte block-hash: Block structure (serialized as a byte slice)
2. 'l': the hash of the last block in a chain
 */
// the name of the blocks bucket in the db
const blocksBucket = "BLOCKS_BUCKET"

// the name of the BoltDB file
const dbFile = "blockchain.db"

func (b *Block) Serialize() []byte {
   var result bytes.Buffer
   encoder := gob.NewEncoder(&result)

   // should process this error, omitted for brevity
   _ = encoder.Encode(b)

   return result.Bytes()
}

func DeserializeBlock(data []byte) *Block {
   var block Block
   decoder := gob.NewDecoder(bytes.NewReader(data))

   // should process this error, omitted for brevity
   _ = decoder.Decode(&block)

   return &block
}

type BlockChainIterator struct {
   currentHash []byte
   db          *bolt.DB
}

func (bc *BlockChain) Iterator() *BlockChainIterator {
   bcit := &BlockChainIterator{bc.tip, bc.db}

   return bcit
}

func (it *BlockChainIterator) Next() *Block {
   var block *Block

   _ = it.db.View(func(tx *bolt.Tx) error {
      b := tx.Bucket([]byte(blocksBucket))
      encodedBlock := b.Get(it.currentHash)
      block = DeserializeBlock(encodedBlock)

      return nil
   })

   it.currentHash = block.PrevBlockHash

   return block
}

type CLI struct {
   bc *BlockChain
}

func (cli *CLI) Run() {
   // NOTE: this line was in the tutorial, but was never shown. Likely excluded
   // for brevity since we aren't really concerned with errors here.
   // cli.validateArgs()

   addBlockCmd := flag.NewFlagSet("addblock", flag.ExitOnError)
   printChainCmd := flag.NewFlagSet("printchain", flag.ExitOnError)

   addBlockData := addBlockCmd.String("data", "", "Block data")

   switch os.Args[1] {
   case "addblock":
      _ = addBlockCmd.Parse(os.Args[2:])
   case "printchain":
      _ = printChainCmd.Parse(os.Args[2:])
   default:
      // NOTE: this line was in the tutorial, but was never shown. Likely excluded
      // for brevity since we aren't really concerned with errors here.
      // cli.printUsage()
      os.Exit(1)
   }

   if addBlockCmd.Parsed() {
      if *addBlockData == "" {
         addBlockCmd.Usage()
         os.Exit(1)
      }

      cli.addBlock(*addBlockData)
   }

   if printChainCmd.Parsed() {
      cli.printChain()
   }
}

func (cli *CLI) addBlock(data string) {
   cli.bc.AddBlock(data)
   fmt.Println("Success!")
}

func (cli *CLI) printChain() {
   bcit := cli.bc.Iterator()
   block := bcit.Next()

   for len(block.PrevBlockHash) != 0 {
      pow := NewProofOfWork(block)
      fmt.Printf("Prev. hash: %x\n", block.PrevBlockHash)
		fmt.Printf("Data: %s\n", block.Data)
		fmt.Printf("Hash: %x\n", block.Hash)
		fmt.Printf("PoW: %s\n", strconv.FormatBool(pow.Validate()))
		fmt.Println()

      block = bcit.Next()
   }
}

func main() {
	bc := NewBlockChain()
	defer bc.db.Close()

	cli := CLI{bc}
	cli.Run()
}
