// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract Project{
  
    struct Volunteer {
        string aadharCardNumber; 
        string name;
        uint age;
        string contactNumber;
        bool verified;
    }
    mapping(string => string) public cleaningdate;
    mapping(address => Volunteer) public advolunteers ;
    mapping(string => Volunteer) public volunteers ;
    event VolunteerRegistered(string indexed aadharCardNumber, string name, uint age, string contactNumber);

    modifier isverified(string memory _aadharCardNumber) {
        require(volunteers[_aadharCardNumber].verified, "Volunteer already registered");
        _;
    }
     
    function registerAsVolunteer(string memory _aadharCardNumber, string memory _name, uint _age, string memory _contactNumber) external{
        //volunteers[_aadharCardNumber]=Volunteer(_aadharCardNumber,_name,_age,_contactNumber,false);
       advolunteers[msg.sender]=Volunteer(_aadharCardNumber,_name,_age,_contactNumber,false);
     emit VolunteerRegistered(_aadharCardNumber, _name, _age, _contactNumber);
    }
    function getVolunteerDetails(string memory _aadharCardNumber) external view returns (string memory, uint, string memory, bool) {
        Volunteer storage volunteer = volunteers[_aadharCardNumber];
        require(volunteer.verified, "Volunteer not registered");

        return (volunteer.name, volunteer.age, volunteer.contactNumber, volunteer.verified);
    }
    function assigncleaningdate(string memory _aadharCardNumber, string memory _cleandate ) public
    {
      require(volunteers[_aadharCardNumber].verified, "Volunteer already registered");
      cleaningdate[_aadharCardNumber]=_cleandate;
    }
}