pragma solidity 0.5.16;

contract Election {
    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint256 public candidatesCount;
    event votedEvent (uint indexed _candidateId);

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    constructor() public {
        addCandidate("Bill Gates");
        addCandidate("Steve Jobs");
        addCandidate("Mark Zuckerberg");
        addCandidate("Elon Musk");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateId) public {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit votedEvent(_candidateId);
    }
}
