// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract Project{
  
    struct Volunteer {
        string aadharCardNumber; 
        string name;
        uint age;
        string contactNumber;
        bool registered;
    }

    mapping(string => Volunteer) public volunteers;

    event VolunteerRegistered(string indexed aadharCardNumber, string name, uint age, string contactNumber);

    modifier notRegistered(string memory _aadharCardNumber) {
        require(!volunteers[_aadharCardNumber].registered, "Volunteer already registered");
        _;
    }

    function registerAsVolunteer(string memory _aadharCardNumber, string memory _name, uint _age, string memory _contactNumber) external notRegistered(_aadharCardNumber) {
        Volunteer storage newVolunteer = volunteers[_aadharCardNumber];
        newVolunteer.aadharCardNumber = _aadharCardNumber;
        newVolunteer.name = _name;
        newVolunteer.age = _age;
        newVolunteer.contactNumber = _contactNumber;
        newVolunteer.registered = true;

        emit VolunteerRegistered(_aadharCardNumber, _name, _age, _contactNumber);
    }

    function getVolunteerDetails(string memory _aadharCardNumber) external view returns (string memory, uint, string memory, bool) {
        Volunteer storage volunteer = volunteers[_aadharCardNumber];
        require(volunteer.registered, "Volunteer not registered");

        return (volunteer.name, volunteer.age, volunteer.contactNumber, volunteer.registered);
    }
}