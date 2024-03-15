// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract Project{
  
    struct Volunteer {
        uint256 aadharCardNumber; 
        string name;
        uint age;
        string contactNumber;
        bool verified;
    }
    mapping(uint256 => string) public cleaningdate;
    mapping(address => Volunteer) public advolunteers ;
    mapping(uint256 => Volunteer) public volunteers ;
    event VolunteerRegistered(uint256 aadharCardNumber, string name, uint age, string contactNumber);

    modifier isverified(uint256 _aadharCardNumber) {
        require(volunteers[_aadharCardNumber].verified, "Volunteer already registered");
        _;
    }
     
    function registerAsVolunteer(uint256 _aadharCardNumber, string memory _name, uint _age, string memory _contactNumber) external{
        volunteers[_aadharCardNumber]=Volunteer(_aadharCardNumber,_name,_age,_contactNumber,false);
       advolunteers[msg.sender]=Volunteer(_aadharCardNumber,_name,_age,_contactNumber,false);
     emit VolunteerRegistered(_aadharCardNumber, _name, _age, _contactNumber);
    }
    function verify(uint256 _aadharCardNumber) public 
    {
          require(volunteers[_aadharCardNumber].aadharCardNumber!=_aadharCardNumber,"Volunteer not exists");
          volunteers[_aadharCardNumber].verified=true;
    }
    function getVolunteerDetails(uint256 _aadharCardNumber) external view returns (string memory, uint, string memory, bool) {
        Volunteer storage volunteer = volunteers[_aadharCardNumber];
        require(volunteer.verified, "Volunteer not registered");

        return (volunteer.name, volunteer.age, volunteer.contactNumber, volunteer.verified);
    }
    function assigncleaningdate(uint256 _aadharCardNumber, string memory _cleandate ) public
    {
      require(volunteers[_aadharCardNumber].verified, "Volunteer already registered");
      cleaningdate[_aadharCardNumber]=_cleandate;
    }
}
