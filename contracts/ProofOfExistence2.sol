pragma solidity ^0.5.0;

contract ProofOfExistence2 {

  // state
  bytes32[] private proofs;

  // store a proof of existence in the contract state
  function storeProof(bytes32 proof) 
    public 
  {
    proofs.push(proof);
  }

  // calculate and store the proof for a document
  function notarize(string calldata document) 
    external 
  {
    bytes32 proof = proofFor(document);
    storeProof(proof);
  }

  // helper function to get a document's sha256
  function proofFor(string memory document) 
    pure 
    public 
    returns (bytes32) 
  {
    return sha256(abi.encodePacked(document));
  }

  // check if a document has been notarized
  function checkDocument(string memory document) 
    public 
    view 
    returns (bool) 
  {
    bytes32 proof = proofFor(document);
    return hasProof(proof);
  }

  // returns true if proof is stored
  function hasProof(bytes32 proof) 
    internal 
    view 
    returns (bool) 
  {
    for (uint256 i = 0; i < proofs.length; i++) {
      if (proofs[i] == proof) {
        return true;
      }
    }
    return false;
  }
}