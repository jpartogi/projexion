CREATE TABLE `acceptances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `accepted` tinyint(1) NOT NULL DEFAULT '0',
  `feature_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acceptances_idx` (`id`,`feature_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `old_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `changed_field` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` int(11) NOT NULL,
  `event_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `events_idx` (`id`,`project_id`,`user_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `feature_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `position` mediumint(3) NOT NULL DEFAULT '1',
  `color` char(6) COLLATE utf8_unicode_ci NOT NULL,
  `default_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_story` text COLLATE utf8_unicode_ci NOT NULL,
  `business_value` decimal(10,0) DEFAULT NULL,
  `story_points` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `sprint_id` int(11) DEFAULT NULL,
  `release_id` int(11) DEFAULT NULL,
  `priority_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `feature_status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `features_idx` (`id`,`sprint_id`,`release_id`,`project_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `meeting_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `occurrence` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `meetings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minutes` text COLLATE utf8_unicode_ci,
  `attachment` blob,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `meeting_type_id` int(11) NOT NULL,
  `location` text COLLATE utf8_unicode_ci,
  `agenda` text COLLATE utf8_unicode_ci,
  `additionals` text COLLATE utf8_unicode_ci,
  `project_id` int(11) NOT NULL,
  `sprint_id` int(11) DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `created_by` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `meetings_idx` (`id`,`meeting_type_id`,`project_id`,`sprint_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `priorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `project_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_role_id` int(11) NOT NULL,
  `status` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_members_uq` (`project_id`,`user_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `project_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `role` text COLLATE utf8_unicode_ci,
  `manager` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `vision` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_uq` (`code`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `release_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `sprint_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `releases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_number` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `estimate_date` date DEFAULT NULL,
  `goal` text COLLATE utf8_unicode_ci,
  `project_id` int(11) NOT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `releases_idx` (`id`,`project_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `sprint_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `last_update` date NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sprint_id` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `sprints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `velocities` mediumint(9) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `project_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `goal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sprints_idx` (`id`,`project_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `task_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) DEFAULT '1',
  `default_status` tinyint(1) DEFAULT NULL,
  `color` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  `sprint_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `task_status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_idx` (`id`,`project_id`,`feature_id`,`sprint_id`,`task_status_id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `single_access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `failed_login_count` int(11) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `current_login_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `current_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Maria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;