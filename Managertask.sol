// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CleaningDrive {

    address public manager;
    uint256 public cleaningDate;
    address public administrator;
    mapping(address => bool) public volunteers;

    event CleaningDriveScheduled(address indexed manager, uint256 cleaningDate);
    event VolunteerRegistered(address indexed volunteer);
    event ParticipationRecordUpdated(address indexed volunteer, uint256 cleaningDate);

    modifier onlyManager() {
        require(msg.sender == manager, "Only the manager can call this function");
        _;
    }

    modifier notRegisteredVolunteer() {
        require(!volunteers[msg.sender], "Volunteer is already registered");
        _;
    }

    constructor() {
        manager = msg.sender;
    }

    function scheduleCleaningDrive(uint256 date) external onlyManager {
        cleaningDate = date;
        emit CleaningDriveScheduled(manager, date);
    }

    function registerAsVolunteer() external notRegisteredVolunteer {
        volunteers[msg.sender] = true;
        emit VolunteerRegistered(msg.sender);
    }
    function updateParticipationRecord() external {
        require(volunteers[msg.sender], "Only registered volunteers can update records");
        require(cleaningDate > 0, "Cleaning drive date not set");
        emit ParticipationRecordUpdated(msg.sender, cleaningDate);
        (bool success, ) = administrator.call(abi.encodeWithSignature("updateParticipationRecord(address,uint256)", msg.sender, cleaningDate));
        require(success, "Failed to update administrator");
    }
    function getCleaningDate() external view returns (uint256) {
        return cleaningDate;
    }
    function isVolunteerRegistered(address volunteer) external view returns (bool) {
        return volunteers[volunteer];
    }
}