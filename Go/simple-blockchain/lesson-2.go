package main

import (
   "fmt"
   "bytes"
   "crypto/sha256"
   "strconv"
   "time"
   "math"
   "math/big"
)

// More bits, more difficult
const targetBits = 20

// Prevents nonce (counter) overflow when computing a hash. Technically, the
// difficulty of hashing here is too low to overflow, but this is done as a
// best practice
const maxNonce = math.MaxInt64


/*
#############################################################################
BEGIN CODE FROM LESSON 1
#############################################################################

EDITS:
--------------------------------------------------------------------------------

The `Nonce` property was added to the block to check track of the nonce related
to the PoW, since it is needed to verify the validity of the hash.

The set hash method was removed, since the `ProofOfWork` struct will now handle
that. This is seen in the `NewBlock` method.
 */
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
   blocks []*Block
}

func (bc *BlockChain) AddBlock(data string) {
   prevBlock := bc.blocks[len(bc.blocks) - 1]
   newBlock := NewBlock(data, prevBlock.Hash)
   bc.blocks = append(bc.blocks, newBlock)
}

func NewBlockChain() *BlockChain {
   blockChain := &BlockChain{[]*Block{NewGenesisBlock()}}
   return blockChain
}

// #############################################################################
// END CODE FROM LESSON 1
// #############################################################################


/*
Utility Methods
--------------------------------------------------------------------------------
 */
func IntToHex(n int64) []byte {
   return []byte(strconv.FormatInt(n, 16))
}

/*
Proof of Work
--------------------------------------------------------------------------------

The main issue with the previous implementation was that adding a block was far
to easy. This undermines the security of the block chain; it should be difficult
to add to the chain.

Many cryptocurrencies such as Bitcoin use a proof-of-work model; a miner that
proves that it has performed sufficient work will be rewarded. This is done by
passing the completed hash to a verifying entity, and if it meets certain
requirements, a block is rewarded. One key to proof-of-work is that while the
work must be difficult, verifying said work via the hash must be computationally
easy (fast).

Proof-of-Work Algorithm - [HashCash](https://en.wikipedia.org/wiki/Hashcash)
1. Combine known data (the block headers in this case) with a counter
   (represented in hexadecimel here, usually will be base-64)
2. Hash the information
3. If the hash meets certain criteria, its good, otherwise increment the counter
   and repeat
This is expensive because the check requires something like x leading zeroes,
where each additional leading zero doubles the amount of time the computation
takes. Due to the brute-force nature of the algorithm, it is expensive.
 */
type ProofOfWork struct {
   block  *Block
   target *big.Int
}

// "nonce" is a cryptographic term for a number that can only be used once. In
// this case, it is the counter
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
   // setting the target to 1, and then left-shifting its value 256 - targetBits
   // places so that the numerical value of the hash can be compared to it. The
   // hash's value must be less than this value, or it is invalid (does not
   // have the required number of leading zeroes).
   target := big.NewInt(1)
   target.Lsh(target, uint(256 - targetBits))

   pow := &ProofOfWork{block, target}

   return pow
}

func (pow *ProofOfWork) Run() (int, []byte) {
   var hashInt big.Int
   var hash [32]byte
   tries := 0
   nonce := 0

   fmt.Printf("Mining the block containing \"%s\"\n", pow.block.Data)

   for nonce < maxNonce {
      // prepare the data
      data := pow.prepareData(nonce)

      // hash the data
      hash = sha256.Sum256(data)

      fmt.Printf("\r%x", hash)

      // convert to a big integer
      hashInt.SetBytes(hash[:])

      // compare to the target (-1 means the hash is less than the target)
      if hashInt.Cmp(pow.target) == -1 {
         break
      } else {
         nonce++
         tries++
      }
   }

   fmt.Printf("\nNumber of Tries: %d\n", tries)
   fmt.Print("\n")

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

// same main as in lesson 1, not grouped with other lesson 1 code for clarity.
func main() {
	bc := NewBlockChain()

	bc.AddBlock("Transaction 1")
	bc.AddBlock("Transaction 2")

	for _, block := range bc.blocks {
      pow := NewProofOfWork(block)
		fmt.Printf("Prev. hash: %x\n", block.PrevBlockHash)
		fmt.Printf("Data: %s\n", block.Data)
		fmt.Printf("Hash: %x\n", block.Hash)
		fmt.Printf("PoW: %s\n", strconv.FormatBool(pow.Validate()))
		fmt.Println()
	}
}
