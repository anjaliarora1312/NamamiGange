// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./volunteer.sol";
import "./Managertask.sol";
contract AccessControl{
    address public administrator;
    address public manager;
    mapping(address=>bool) public managers;
    mapping(address => bool) public accountManagers;
    Project public volun;
    CleaningDrive public manage;
   // mapping(address => bool) public volunteers;
    mapping(address => bool) public canSchedule;
    event getName(string);
    event ManagerGranted(address indexed manager);
    event ManagerAdded(address indexed managerAddress);
    event AccountManagerAdded(address indexed accountManagerAddress);
    //event VolunteerAdded(address indexed volunteerAddress);
     event VolunteerVerified(address volunteer, address admin);
    event ManagerRemoved(address indexed managerAddress);
    event AccountManagerRemoved(address indexed accountManagerAddress);
    event VolunteerRemoved(string _aadharCardNumber, string _name, uint _age, string _contactNumber);
    event CleaningDriveScheduled(address indexed manager, uint256 startTime, uint256 endTime);
   modifier onlyManagerOrAdmin() {
        require(msg.sender == manager || msg.sender == administrator, "Only manager or admin can call this function");
        _;
    }   
    modifier onlyAdministrator(){
          require(msg.sender == administrator, "Only administrator can perform this action");
        _;
    }
    modifier onlyManager() {
        require(managers[msg.sender], "Only manager can perform this action");
        _;
    }
    modifier onlyAccountManager() {
        require(accountManagers[msg.sender], "Only account manager can perform this action");
        _;
    }
    constructor(address _volunteeraddr, address _manageaddress) {
        administrator = msg.sender;
        volun = Project(_volunteeraddr);
        manage=CleaningDrive(_manageaddress);
    }
    function addManager(address _manager) external onlyAdministrator {
        managers[_manager] = true;
        emit ManagerAdded(_manager);
    }
   function removeManager(address _manager) external onlyAdministrator {
        managers[_manager] = false;
        emit ManagerRemoved(_manager);
    }
    function addAccountManager(address _accountManager) external onlyAdministrator {
        accountManagers[_accountManager] = true;
        emit AccountManagerAdded(_accountManager);
    }
    function removeAccountManager(address _accountManager) external onlyAdministrator {
        accountManagers[_accountManager] = false;
        emit AccountManagerRemoved(_accountManager);
    }
    function removeVolunteer(string memory _aadharCardNumber, string memory _name, uint _age, string memory _contactNumber) external onlyAdministrator {
    require (volun.registerAsVolunteer(_aadharCardNumber,_name,_age,_contactNumber,false)
       emit VolunteerRemoved(_aadharCardNumber,_name,_age,_contactNumber);
    }
   //  function grantManagerRole(address _manager) external onlyAdministrator {
     //   manager = _manager;
        //canSchedule[_manager] = true;
        //emit ManagerGranted(_manager);
    //}
    function scheduleCleaningDrive(uint256 startTime, uint256 endTime) external onlyManagerOrAdmin 
    {
       require(canSchedule[msg.sender], "You do not have the right to schedule cleaning drives");
        require(startTime < endTime, "Invalid time range");
        emit CleaningDriveScheduled(msg.sender, startTime, endTime);
     }
      function verifyVolunteer(address volunteer) external onlyAdministrator() {
        require(volun.registeredVolunteers[volunteer], "Volunteer is not registered");
        emit VolunteerVerified(volunteer, msg.sender);
    }
}