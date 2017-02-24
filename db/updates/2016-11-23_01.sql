CREATE TABLE `cupom` (
  `cupom_id` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `event_id` int(11) NOT NULL,
  `cupom_type` enum('percent','fixed') NOT NULL,
  `value` float NOT NULL,
  `valid` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `cupom`
  ADD PRIMARY KEY (`cupom_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `valid` (`valid`);


ALTER TABLE `cupom`
  MODIFY `cupom_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `cupom`
  ADD CONSTRAINT `cupom_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `cupom` ADD INDEX(`code`);

