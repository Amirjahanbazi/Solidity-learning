// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Twitter{

    struct TwittInfo{
        uint id;
        string text;
        uint date;
        address accId;
        uint likeNums;
    }
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }
    uint length = 20;

    mapping(address => TwittInfo[]) private  Tf;

    function Tw(string memory text)public {

        TwittInfo memory NewT = TwittInfo({id:Tf[msg.sender].length,text:text,date:block.timestamp,accId:msg.sender,likeNums:0});
        require(bytes(text).length <= length);
        Tf[msg.sender].push(NewT);
    }

    function ChengeTwitterLength(uint newlength)public OnlyOwner {
        length = newlength;

    }

    function liketwitt(address accid , uint tid)public {
        require(Tf[accid][tid].id == tid);
        Tf[accid][tid].likeNums++;
    }
    function unliketwitt(address accid , uint tid)public {
        require(Tf[accid][tid].id == tid);
        require(Tf[accid][tid].likeNums > 0);
        Tf[accid][tid].likeNums--;
    }


    function getTwitt(uint index)public view returns (TwittInfo memory){
        return Tf[msg.sender][index];
    }

    function getAllTwitt()public view returns (TwittInfo[] memory){
        
        return Tf[msg.sender];
    }
}


