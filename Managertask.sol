// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./volunteer.sol";
contract CleaningDrive {


    struct Manager {
        string aadharCardNumber; 
        string name;
        uint age;
        string contactNumber;
        address admanager;
    }
    Manager public manager;
    Project public volunter;
    event CleaningDriveScheduled(address indexed manager, string date);
    function addmanager(string memory _aadharCardNumber, string memory _name, uint256 _age, string memory _contactNumber, address _admanager) public
    {
        manager=Manager(_aadharCardNumber,_name,_age,_contactNumber,_admanager);
    }
    modifier onlyManager() {
        require(msg.sender == manager.admanager, "Only the manager can call this function");
        _;
    }
   function scheduleCleaningDrive(string memory date, string memory aadharcard) external onlyManager {
        volunter.assigncleaningdate(aadharcard,date);
        emit CleaningDriveScheduled(manager.admanager, date);
    }
   constructor(address _volunteeraddr) {
       
        volunter = Project(_volunteeraddr);
      
    }
}
