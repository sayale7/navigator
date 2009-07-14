# Sequel Pro dump
# Version 663
# http://code.google.com/p/sequel-pro
#
# Host: localhost (MySQL 5.0.81)
# Database: rails_development
# Generation Time: 2009-07-14 19:58:38 +0200
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table folders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `folders`;

CREATE TABLE `folders` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` (`id`,`user_id`,`parent_id`,`name`,`created_at`,`updated_at`)
VALUES
	(8,6,NULL,'Inbox','2009-07-14 15:50:01','2009-07-14 15:50:01'),
	(9,6,NULL,'Trash','2009-07-14 15:50:01','2009-07-14 15:50:01'),
	(10,7,NULL,'Inbox','2009-07-14 15:50:19','2009-07-14 15:50:19'),
	(11,7,NULL,'Trash','2009-07-14 15:50:19','2009-07-14 15:50:19'),
	(12,8,NULL,'Inbox','2009-07-14 17:57:38','2009-07-14 17:57:38'),
	(13,8,NULL,'Trash','2009-07-14 17:57:38','2009-07-14 17:57:38');

/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table message_copies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `message_copies`;

CREATE TABLE `message_copies` (
  `id` int(11) NOT NULL auto_increment,
  `recipient_id` int(11) default NULL,
  `message_id` int(11) default NULL,
  `folder_id` int(11) default NULL,
  `deleted` tinyint(1) NOT NULL default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `read` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;



# Dump of table messages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL auto_increment,
  `author_id` int(11) default NULL,
  `subject` varchar(255) default NULL,
  `body` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;



# Dump of table pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `content` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;



# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `body` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;



# Dump of table recipients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recipients`;

CREATE TABLE `recipients` (
  `id` int(11) NOT NULL auto_increment,
  `message_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;



# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) default NULL,
  `authorizable_type` varchar(40) default NULL,
  `authorizable_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`,`name`,`authorizable_type`,`authorizable_id`,`created_at`,`updated_at`)
VALUES
	(1,'admin',NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table roles_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles_users`;

CREATE TABLE `roles_users` (
  `user_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` (`user_id`,`role_id`,`created_at`,`updated_at`)
VALUES
	(6,1,NULL,NULL),
	(8,1,NULL,NULL);

/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` (`version`)
VALUES
	('20090513231250'),
	('20090611111443'),
	('20090612153119'),
	('20090615163736'),
	('20090615164428'),
	('20090616155050'),
	('20090616155106'),
	('20090616155116'),
	('20090705221056'),
	('5');

/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `crypted_password` varchar(255) default NULL,
  `password_salt` varchar(255) default NULL,
  `persistence_token` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`username`,`email`,`crypted_password`,`password_salt`,`persistence_token`,`created_at`,`updated_at`)
VALUES
	(6,'admin','admin@admin.com','64b6c35caf747fd827754d2adb7d66388179bc218e02e51bb3c8d44fe21339d61746552bd613206111dc8ab4288e52eb6327f41b7ffc2aa74859cdaaf5ced528','eb6AZ-NkPZohJ0afYTS8','57e203ce1962370fa7b6fd8347d7d2682598a2a91abdf45b4282479ee5f01ddf78ec691c73a0f8a6f865d2b6705c437fd08bbbccb7e52d7d0d1e7e678d894206','2009-07-14 15:50:01','2009-07-14 15:50:01'),
	(7,'demo','demo@demo.com','937df2e5ce4e0c0f9225941261b96ccb3d72b3f1fef8dd6f05754616b308bb733300388b1f2af975fb92681659e7c776e143c3b777185f58c856e63c884ea6d5','xFn-k7W2-FeySAeVT3lE','3dcf85450d06f2d93a1f037b64bdd91c99133d4cb173713ae05fc86d3756ea1b9fdfd96bd44b4cb181d9f38bc4065a6fece8321220e3cf1587f7ac5c8d17752e','2009-07-14 15:50:19','2009-07-14 15:50:19'),
	(8,'thomas','thomas.kohler@gmx.at','7d8b57fab72a1a4471b812303c871b0c4efbcad534383ca3b4f72ae5145897ef0439a88d82b80c5b56486d65678d98c7bc43bd02d10cdca6192b7dd470d94a34','8RH4BAiHV2uVhX0-EFSh','fed2c87dadd111c3d9b44a6d05f9d2285bb5afb06d7c6c72de22038823c52de5d9fd0e0b1475246bb919ce6d5ee902d9d1f3a08ce07f8a168ecafb3b6cc3674b','2009-07-14 17:57:38','2009-07-14 17:57:38');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
