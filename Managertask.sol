// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./volunteer.sol";
contract CleaningDrive {


    struct Manager {
        uint256 aadharCardNumber; 
        string name;
        uint age;
        string contactNumber;
        address admanager;
    }
    Manager public manager;
    Project public volunter;
     mapping(address => Manager) public managers;
    event CleaningDriveScheduled(address indexed manager, string date);
     
      function setmanager(uint256 _aadharCardNumber, string memory _name, uint256 _age, string memory _contactNumber, address _admanager) public
    {
        manager=Manager(_aadharCardNumber,_name,_age,_contactNumber,_admanager);
    }
    
     //function setmanager(uint256 _aadharCardNumber, string memory _name, uint256 _age, string memory _contactNumber, address _admanager) public {
       // require(managers[_admanager].aadharCardNumber == 0, "Manager already exists");
        // managers[_admanager]= Manager({
           // aadharCardNumber: _aadharCardNumber,
           // name: _name,
            //age: _age,
           // contactNumber: _contactNumber,
            //admanager: _admanager
        //});
   // }
    modifier onlyManager() {
        require(msg.sender == manager.admanager, "Only the manager can call this function");
        _;
    }
   function scheduleCleaningDrive(string memory date, uint256 aadharcard) external onlyManager {
        volunter.assigncleaningdate(aadharcard,date);
        emit CleaningDriveScheduled(manager.admanager, date);
    }

  
}
