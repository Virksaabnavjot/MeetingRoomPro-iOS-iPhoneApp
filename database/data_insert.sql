-- Inserting a building in buildings table along with building coordinate
INSERT INTO `mrp_buildings` (
  `buildingId`, `companyId`, `name`, `noOfFloors`,
  `coordinates`, `city`, `country`, `address`, `phone`,
  `email`) VALUES (
    '1', '1', 'National College of Ireland', '4',
    PolyFromText('POLYGON((33.294974 -2.426631, 53.294847 -6.426419,
      73.294289 -6.426888, 13.294326 -6.427194, 43.294974 -6.426631,
      33.294974 -2.426631))'), 'Dublin', 'Ireland', 'Mayor Street,
      IFSC, Dublin 1, D01 Y300', '01449 8500', 'admissions@ncirl.ie ');


INSERT INTO `mrp_meeting_rooms` (
  `meetingRoomId`, `buildingId`, `name`, `floorNumber`, `coordinates`,
  `capacity`, `type`, `phone`, `email`, `directions`) VALUES (
    '1', '1', 'SCR1', '1', PointFromText('Point(83.294846 -4.426421)'),
    '71', 'ClassRoom', '01449 8500', 'scr1@ncirl.ie',
    'Walk on your left hand side open the door close to stairs, the first room on your left');


INSERT INTO `mrp_companies` (
  `companyId`, `name`, `headquarters`, `website`, `email`, `ceo`,
  `industry`, `tagline`) VALUES (
    '1', 'National College of Ireland', 'Mayor Street, IFSC, Dublin 1,
    D01 Y300, Ireland, Europe', 'https://ncirl.ie', 'contact@ncirl.ie',
    'Gina Quin (President)', 'Education', 'NCI - Changing Lives through Education');