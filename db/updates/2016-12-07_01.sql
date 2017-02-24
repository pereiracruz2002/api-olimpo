ALTER TABLE `event_types` ADD `img` VARCHAR(255) NOT NULL AFTER `name`;
ALTER TABLE `event_types` ADD `plural` VARCHAR(150) NOT NULL AFTER `name`;
ALTER TABLE `event_types` CHANGE `name` `name` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
CREATE TABLE `user_notifications_config` (
  `user_notifications_config_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `invites` tinyint(1) NOT NULL,
  `events_near` tinyint(1) NOT NULL,
  `friends` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `user_notifications_config`
  ADD PRIMARY KEY (`user_notifications_config_id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `user_notifications_config`
  MODIFY `user_notifications_config_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `user_notifications_config`
  ADD CONSTRAINT `user_notifications_config_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `user_notifications_config` CHANGE `invites` `invites` TINYINT(1) NOT NULL DEFAULT '1', CHANGE `events_near` `events_near` TINYINT(1) NOT NULL DEFAULT '1', CHANGE `friends` `friends` TINYINT(1) NOT NULL DEFAULT '1';

