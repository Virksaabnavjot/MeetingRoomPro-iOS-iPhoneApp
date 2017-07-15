CREATE TABLE `mrp_buildings` (
  `buildingId` int(120) NOT NULL,
  `name` varchar(120) NOT NULL,
  `numberOfFloors` int(120) NOT NULL,
  `coordinates` geometry NOT NULL,
  `city` varchar(120) NOT NULL,
  `country` varchar(120) NOT NULL,
  `address` varchar(240) NOT NULL,
  `phone` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
ALTER TABLE `mrp_buildings`
ADD PRIMARY KEY (`buildingId`);




CREATE TABLE `navsingh_MRPro`.`mrp_meeting_rooms` ( 
  `meetingRoomId`INT(120) NOT NULL ,
  `buildingId` INT(120) NOT NULL , 
  `name` VARCHAR(120)NOT NULL , 
  `floorNumber` INT(120) NOT NULL , 
  `coordinates` POINT NOTNULL , 
  `capacity` INT(120) NOT NULL , 
  `type` VARCHAR(120) NOT NULL ,
  `phone` VARCHAR(120) NOT NULL , 
  `email` VARCHAR(120) NOT NULL ,
  `directions` VARCHAR(480) NOT NULL , PRIMARY KEY (`meetingRoomId`))ENGINE = MyISAM;
