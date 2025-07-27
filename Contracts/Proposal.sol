// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract proposals{

    struct Proposal{
        uint id;
        string name;
        uint   duration;
        string describe;
        bool IsActive;
        uint Yes;
        uint No;
    }

    address Owner;

    mapping (uint=> mapping(address => bool)) private IsVoted;
    Proposal[] public  List;

    constructor(){
        Owner = msg.sender;
    }

    modifier OnlyOwner(){
        require(Owner == msg.sender , "Only Owner Allowed");
        _;
    }
    event ProposalCreated(uint id, string name, uint endTime);
    event Voted(uint id, address voter, bool support);

    function CreateProposals(string memory name , uint daysAmount , string memory describe)public OnlyOwner {
        Proposal memory NewProposoal = Proposal({id : List.length, name : name , duration : block.timestamp + daysAmount*24*60*60 , describe : describe , Yes:0 , No:0 , IsActive : true});
        List.push(NewProposoal);

        emit ProposalCreated(List.length-1, name, List[List.length-1].duration);

    }

    
    function NotActive(uint id)private  {
        if (List[id].duration <= block.timestamp){
            List[id].IsActive = false;
        }
    }


    function vote(uint id, bool support) public  {
        NotActive(id);
        require(List[id].IsActive, "Proposal is inactive");
        require(IsVoted[id][msg.sender] == false);
        if (support) {
            List[id].Yes++;
        } else {
            List[id].No++;
        }
        IsVoted[id][msg.sender] = true;
        emit Voted(id, msg.sender, support);

    }


}

