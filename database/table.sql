--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `roomID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `startDate` int(11) NOT NULL,
  `endDate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `booking_invitations`
--

CREATE TABLE `booking_invitations` (
  `id` int(11) NOT NULL,
  `bookingID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `city` text NOT NULL,
  `country` text NOT NULL,
  `floors` varchar(10) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(30) NOT NULL,
  `coordinates` polygon NOT NULL,
  `location` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `mrp_companies`
--

CREATE TABLE `mrp_companies` (
  `companyId` int(120) NOT NULL,
  `name` varchar(240) COLLATE utf8_unicode_ci NOT NULL,
  `headquarters` varchar(480) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `ceo` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `industry` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `tagline` varchar(120) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `roomId` int(120) NOT NULL,
  `buildingId` int(120) NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `floorNumber` int(120) NOT NULL,
  `coordinates` point NOT NULL,
  `capacity` int(120) NOT NULL,
  `type` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `directions` varchar(480) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table `room_pictures`
--

CREATE TABLE `room_pictures` (
  `id` int(11) NOT NULL,
  `roomID` int(11) NOT NULL,
  `url` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table `room_reviews`
--

CREATE TABLE `room_reviews` (
  `id` int(11) NOT NULL,
  `roomID` int(11) NOT NULL,
  `review` text COLLATE utf8_unicode_ci NOT NULL,
  `rating` float NOT NULL,
  `userID` int(11) NOT NULL,
  `userName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `picture` text NOT NULL,
  `deviceToken` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mrp_companies`
--
ALTER TABLE `mrp_companies`
ADD PRIMARY KEY (`companyId`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
ADD PRIMARY KEY (`roomId`);

--
-- Indexes for table `room_pictures`
--
ALTER TABLE `room_pictures`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_reviews`
--
ALTER TABLE `room_reviews`
ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `buildings`
--
ALTER TABLE `buildings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
MODIFY `roomId` int(120) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `room_pictures`
--
ALTER TABLE `room_pictures`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `room_reviews`
--
ALTER TABLE `room_reviews`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
