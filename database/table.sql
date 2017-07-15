CREATE TABLE `navsingh_MRPro`.`mrp_companies` (
    `companyId` INT(120) NOT NULL ,
    `name` VARCHAR(240) NOT NULL ,
    `headquarters` VARCHAR(480) NOT NULL ,
    `website` VARCHAR(120) NOT NULL ,
    `email` VARCHAR(120) NOT NULL ,
    `ceo` VARCHAR(120) NOT NULL ,
    `industry` VARCHAR(120) NOT NULL ,
    `tagline` VARCHAR(120) NOT NULL , PRIMARY KEY (`companyId`)) ENGINE = MyISAM;




CREATE TABLE `navsingh_MRPro`.`mrp_buildings` (
  `buildingId` INT(120) NOT NULL ,
  `companyId` INT(120) NOT NULL ,
  `name` VARCHAR(120) NOT NULL ,
  `noOfFloors` INT(120) NOT NULL ,
  `coordinates` POLYGON NOT NULL ,
  `city` VARCHAR(120) NOT NULL ,
  `country` VARCHAR(120) NOT NULL ,
  `address` VARCHAR(240) NOT NULL ,
  `phone` VARCHAR(120) NOT NULL ,
  `email` VARCHAR(120) NOT NULL , PRIMARY KEY (`buildingId`)) ENGINE = MyISAM;




  CREATE TABLE `navsingh_MRPro`.`mrp_meeting_rooms` ( 
    `meetingRoomId`INT(120) NOT NULL ,
    `buildingId` INT(120) NOT NULL , 
    `name` VARCHAR(120)NOT NULL , 
    `floorNumber` INT(120) NOT NULL , 
    `coordinates` POINT NOT NULL , 
    `capacity` INT(120) NOT NULL , 
    `type` VARCHAR(120) NOT NULL ,
    `phone` VARCHAR(120) NOT NULL , 
    `email` VARCHAR(120) NOT NULL ,
    `directions` VARCHAR(480) NOT NULL , PRIMARY KEY (`meetingRoomId`))ENGINE = MyISAM;



  CREATE TABLE `navsingh_MRPro`.`mrp_users` (
    `userId` INT(120) NOT NULL , `name` VARCHAR(120) NOT NULL ,
    `accountType` VARCHAR(120) NOT NULL , `email` VARCHAR(120) NOT NULL ,
    `phone` VARCHAR(120) NOT NULL , `password` VARCHAR(240) NOT NULL ,
    `token` VARCHAR(240) NOT NULL , `companyId` INT(120) NOT NULL , PRIMARY KEY (`userId`)) ENGINE = MyISAM;




    
