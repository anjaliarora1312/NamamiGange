// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./volunteer.sol";
import "./manager.sol";
contract AccessControl{
    address public administrator;
    Project public volun;
    CleaningDrive public manage;
     event ManagerAdded(address indexed managerAddress);
     event VolunteerVerified(uint256 aadharCardNumber);

     modifier onlyAdministrator() {
        require(msg.sender == administrator, "Only administrator can perform this action");
        _;
    }
   
    function addManager(uint256 _aadharCardNumber, string memory _name, uint256 _age, string memory _contactNumber, address _admanager) external  {
        //managers[_aadharCardNumber] _name,_age,_contactNumber,_admanager] = true;
        manage.setmanager(_aadharCardNumber,_name,_age,_contactNumber,_admanager);
        emit ManagerAdded(_admanager);
    }
    function verifyVolunteer(uint256 _aadharCardNumber) external onlyAdministrator() {
        volun.verify(_aadharCardNumber);
        emit VolunteerVerified(_aadharCardNumber);
    }

}
