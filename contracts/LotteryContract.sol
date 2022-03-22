// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract LotteryContract {
    address public admin;
    address payable[] public games;
    
    constructor(){
      admin = msg.sender;
    }

    function buyTikect() public payable{
      require(msg.value == 1 ether);
      games.push(payable(msg.sender));
    }

    function getPrize() public view returns(uint){
      return address(this).balance;
    }

    function getGames() public view returns(address payable[] memory){
      return games;
    }

    function random() public view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,games.length)));
    }

    function pickWinner() public{
      require(msg.sender == admin);
      uint r = random();
      address payable gameWinner;
      uint index = r % games.length;
      gameWinner = games[index];
      gameWinner.transfer(getPrize());
      games = new address payable[](0);//setea el array

    }

}