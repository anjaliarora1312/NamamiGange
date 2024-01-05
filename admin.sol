// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./volunteer.sol";
import "./Managertask.sol";
contract AccessControl{
    address public administrator;
    Project public volun;
    CleaningDrive public manage;
     event ManagerAdded(address indexed managerAddress);
     event VolunteerVerified(string aadharCardNumber);

     modifier onlyAdministrator() {
        require(msg.sender == administrator, "Only administrator can perform this action");
        _;
    }
    constructor(address _volunteeraddr, address _manageaddress) {
        administrator = msg.sender;
        volun = Project(_volunteeraddr);
        manage=CleaningDrive(_manageaddress);
    }
    function addManager(string memory _aadharCardNumber, string memory _name, uint256 _age, string memory _contactNumber, address _admanager) external onlyAdministrator {
        //managers[_aadharCardNumber] _name,_age,_contactNumber,_admanager] = true;
        manage.setmanager(_aadharCardNumber,_name,_age,_contactNumber,_admanager);
        emit ManagerAdded(_admanager);
    }
    function verifyVolunteer(string memory _aadharCardNumber, string memory _name, uint _age, string memory _contactNumber) external onlyAdministrator{
        volun.registerAsVolunteer(_aadharCardNumber,_name,_age,_contactNumber);
        emit VolunteerVerified(_aadharCardNumber);
    }

}
