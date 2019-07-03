package main

import (
   "fmt"
   "strconv"
   "bytes"
   "crypto/sha256"
   "time"
)

/*
BLOCK
-----------------------------------------------------------------------------

In a true implementation, such as that of Bitcoin, `Timestamp`, `PrevBlockHash`,
and `Hash` would be in a separate data structure (BlockHeader), and all the
transaction information also be its own structure. For simplicity, the
transaction information is represented here as `Data`.

The method of hashing here is critical; this is what keeps the blockchain
secure. The hashing operation is intentional computationally expensive, such
that it is very difficult to modify a block once it has been added to the chain.
 */
type Block struct {
   Timestamp int64
   Data []byte
   PrevBlockHash []byte
   Hash []byte
}

/*
This is a simple hashing method, for now.
 */
func (b *Block) SetHash() {
   timestamp := []byte(strconv.FormatInt(b.Timestamp, 10))
   // FIXME: there has to be a better way to do this
   headers := bytes.Join([][]byte{b.PrevBlockHash, b.Data, timestamp}, []byte{})
   hash := sha256.Sum256(headers)

   b.Hash = hash[:]
}

/*
Block struct "constructor"
 */
func NewBlock(data string, prevBlockHash []byte) *Block {
   block := &Block{time.Now().Unix(), []byte(data), prevBlockHash, []byte{}}
   block.SetHash()
   return block;
}

/*
Genesis block (first block in the chain) "constructor"
 */
func NewGenesisBlock() *Block {
   return NewBlock("Genesis Block", []byte{})
}

/*
BLOCK CHAIN
-----------------------------------------------------------------------------

Essentially, all the blockchain is is a database structured as an ordered,
back-linked list.

Since the blockchain is back-linked, there has to be at least one block in the
chain at any given time. This initial block is called the genesis block.
 */
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

func main() {
	bc := NewBlockChain()

	bc.AddBlock("Send 1 BTC to Ivan")
	bc.AddBlock("Send 2 more BTC to Ivan")

	for _, block := range bc.blocks {
		fmt.Printf("Prev. hash: %x\n", block.PrevBlockHash)
		fmt.Printf("Data: %s\n", block.Data)
		fmt.Printf("Hash: %x\n", block.Hash)
		fmt.Println()
	}
}
