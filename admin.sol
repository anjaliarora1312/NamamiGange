// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract AccessControl{
    address public administrator;
    address public manager;
    mapping(address=>bool) public managers;
    mapping(address => bool) public accountManagers;
    mapping(address => bool) public volunteers;
   mapping(address => bool) public canSchedule;
   event ManagerGranted(address indexed manager);
    event ManagerAdded(address indexed managerAddress);
    event AccountManagerAdded(address indexed accountManagerAddress);
    event VolunteerAdded(address indexed volunteerAddress);
    event ManagerRemoved(address indexed managerAddress);
    event AccountManagerRemoved(address indexed accountManagerAddress);
    event VolunteerRemoved(address indexed volunteerAddress);
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

    modifier onlyVolunteer() {
        require(volunteers[msg.sender], "Only volunteer can perform this action");
        _;
    }
    constructor() {
        administrator = msg.sender;
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

    function addVolunteer(address _volunteer) external onlyAdministrator {
        volunteers[_volunteer] = true;
        emit VolunteerAdded(_volunteer);
    }

    function removeVolunteer(address _volunteer) external onlyAdministrator {
        volunteers[_volunteer] = false;
        emit VolunteerRemoved(_volunteer);
    }
     function grantManagerRole(address _manager) external onlyAdministrator {
        manager = _manager;
        canSchedule[_manager] = true;
        emit ManagerGranted(_manager);
    }
    function scheduleCleaningDrive(uint256 startTime, uint256 endTime) external onlyManagerOrAdmin {
        require(canSchedule[msg.sender], "You do not have the right to schedule cleaning drives");
        require(startTime < endTime, "Invalid time range");
        emit CleaningDriveScheduled(msg.sender, startTime, endTime);
     }
}