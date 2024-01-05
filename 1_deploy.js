const fs = require('fs');
const path = require('path');
const CAccessControl = artifacts.require("AccessControl");
const CProject = artifacts.require("Project");
const CManagertask =artifacts.require("CleaningDrive")
module.exports = async function (deployer) {
  await deployer.deploy(CProject);
  const Projectinstance=await CProject.deployed();
  await deployer.deploy(CManagertask,Projectinstance.address);
   const Managertaskinstance=await CManagertask.deployed();
 // const instance = await CAccessControl.deployed();
  await deployer.deploy(CAccessControl,Managertaskinstance.address,Projectinstance.address);
   const AccessControlinstance=await CAccessControl.deployed();
  const addressFilePath = "contractAddress.json"
  const addressObject = {
    CProject_address:Projectinstance.address,
    CManagertask_address:Managertaskinstance.address,
    CAccessControl_address: AccessControlinstance.address,
  };
  fs.writeFileSync(addressFilePath, JSON.stringify(addressObject));
};