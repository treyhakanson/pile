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
BEGIN CODE FROM LESSON 3
#############################################################################

EDITS:
--------------------------------------------------------------------------------
*/

const targetBits = 24
const maxNonce = math.MaxInt64
const blocksBucket = "BLOCKS_BUCKET"
const dbFile = "blockchain.db"

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

func NewBlockChain() *BlockChain {
   var tip []byte

   db, _ := bolt.Open(dbFile, 0600, nil)

   _ = db.Update(func(tx *bolt.Tx) error {
      b := tx.Bucket([]byte(blocksBucket))

      if b == nil {
         genesis := NewGenesisBlock()
         b, _ = tx.CreateBucket([]byte(blocksBucket))
         _ = b.Put(genesis.Hash, genesis.Serialize())
         _ = b.Put([]byte("l"), genesis.Hash)
         tip = genesis.Hash
      } else {
         tip = b.Get([]byte("l"))
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

func (b *Block) Serialize() []byte {
   var result bytes.Buffer
   encoder := gob.NewEncoder(&result)

   _ = encoder.Encode(b)

   return result.Bytes()
}

func DeserializeBlock(data []byte) *Block {
   var block Block
   decoder := gob.NewDecoder(bytes.NewReader(data))

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
   addBlockCmd := flag.NewFlagSet("addblock", flag.ExitOnError)
   printChainCmd := flag.NewFlagSet("printchain", flag.ExitOnError)

   addBlockData := addBlockCmd.String("data", "", "Block data")

   switch os.Args[1] {
   case "addblock":
      _ = addBlockCmd.Parse(os.Args[2:])
   case "printchain":
      _ = printChainCmd.Parse(os.Args[2:])
   default:
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
// #############################################################################
// END CODE FROM LESSON 3
// #############################################################################

/*
Transactions
--------------------------------------------------------------------------------

The whole point of the blockchain is to store transactions in a secure and
reliable way, such that they cannot be modified after they are created. Because
the blockchain is an open database, no sensitive information is stored about
wallet owners. The chain is stricty of transactions.

Inputs of a new transaction reference outputs of a previous transaction. Coins
are stored in outputs. Some outputs from one transaction may not be linked to
any inputs of another transaction. In one transaction, inputs may reference
outputs from multiple other transactions. An input *must* reference an output.
[Transaction Diagram](https://jeiwan.cc/images/transactions-diagram.png)
 */

type Transaction struct {
   ID   []byte
   Vin  []TXInput
   Vout []TXOutput
}

type TXOutput struct {
   Value        int
   ScriptPubKey string
}

func main() {
	bc := NewBlockChain()
	defer bc.db.Close()

	cli := CLI{bc}
	cli.Run()
}
