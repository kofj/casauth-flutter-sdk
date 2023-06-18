-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: casdoor
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `homepage_url` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `cert` varchar(100) DEFAULT NULL,
  `enable_password` tinyint(1) DEFAULT NULL,
  `enable_sign_up` tinyint(1) DEFAULT NULL,
  `enable_signin_session` tinyint(1) DEFAULT NULL,
  `enable_auto_signin` tinyint(1) DEFAULT NULL,
  `enable_code_signin` tinyint(1) DEFAULT NULL,
  `enable_saml_compress` tinyint(1) DEFAULT NULL,
  `enable_web_authn` tinyint(1) DEFAULT NULL,
  `enable_link_with_email` tinyint(1) DEFAULT NULL,
  `org_choice_mode` varchar(255) DEFAULT NULL,
  `saml_reply_url` varchar(100) DEFAULT NULL,
  `providers` mediumtext,
  `signup_items` varchar(1000) DEFAULT NULL,
  `grant_types` varchar(1000) DEFAULT NULL,
  `client_id` varchar(100) DEFAULT NULL,
  `client_secret` varchar(100) DEFAULT NULL,
  `redirect_uris` varchar(1000) DEFAULT NULL,
  `token_format` varchar(100) DEFAULT NULL,
  `expire_in_hours` int DEFAULT NULL,
  `refresh_expire_in_hours` int DEFAULT NULL,
  `signup_url` varchar(200) DEFAULT NULL,
  `signin_url` varchar(200) DEFAULT NULL,
  `forget_url` varchar(200) DEFAULT NULL,
  `affiliation_url` varchar(100) DEFAULT NULL,
  `terms_of_use` varchar(100) DEFAULT NULL,
  `signup_html` mediumtext,
  `signin_html` mediumtext,
  `theme_data` text,
  `form_css` text,
  `form_css_mobile` text,
  `form_offset` int DEFAULT NULL,
  `form_side_html` mediumtext,
  `form_background_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES ('admin','app-built-in','2023-06-19T06:55:43Z','Casdoor','https://cdn.casbin.org/img/casdoor-logo_1185x256.png','https://casdoor.org','','built-in','cert-built-in',1,1,0,0,0,0,0,0,'','','[{\"owner\":\"\",\"name\":\"provider_captcha_default\",\"canSignUp\":false,\"canSignIn\":false,\"canUnlink\":false,\"prompted\":false,\"alertType\":\"None\",\"rule\":\"None\",\"provider\":null}]','[{\"name\":\"ID\",\"visible\":false,\"required\":true,\"prompted\":false,\"rule\":\"Random\"},{\"name\":\"Username\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Display name\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Password\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Confirm password\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Email\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"Normal\"},{\"name\":\"Phone\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Agreement\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"}]','null','d71e1361fe366d36bf04','ccb581dda4d06706c8ea37c1d9328f97e3a98459','[]','',168,0,'','','','','','','',NULL,'','',2,'',''),('admin','testapp','2023-06-19T19:08:10+08:00','测试应用','https://cdn.casbin.org/img/casdoor-logo_1185x256.png','','','dev','cert-built-in',1,1,0,0,0,0,0,0,NULL,'','[]','[{\"name\":\"ID\",\"visible\":false,\"required\":true,\"prompted\":false,\"rule\":\"Random\"},{\"name\":\"Username\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Display name\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Password\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Email\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"Normal\"},{\"name\":\"Phone\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Agreement\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"}]','[\"authorization_code\",\"token\",\"id_token\",\"refresh_token\"]','45bcc334a4ca4b0b6eaf','1a30d06eb4b41f29e1bb4360a4bbc33bfdae7d96','[\"http://localhost:9000/callback\"]','JWT',168,0,'','','','','','','',NULL,'',NULL,2,'','');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casbin_adapter`
--

DROP TABLE IF EXISTS `casbin_adapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casbin_adapter` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `database_type` varchar(100) DEFAULT NULL,
  `database` varchar(100) DEFAULT NULL,
  `table` varchar(100) DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casbin_adapter`
--

LOCK TABLES `casbin_adapter` WRITE;
/*!40000 ALTER TABLE `casbin_adapter` DISABLE KEYS */;
/*!40000 ALTER TABLE `casbin_adapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casbin_rule`
--

DROP TABLE IF EXISTS `casbin_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casbin_rule` (
  `ptype` varchar(100) NOT NULL DEFAULT '',
  `v0` varchar(100) NOT NULL DEFAULT '',
  `v1` varchar(100) NOT NULL DEFAULT '',
  `v2` varchar(100) NOT NULL DEFAULT '',
  `v3` varchar(100) NOT NULL DEFAULT '',
  `v4` varchar(100) NOT NULL DEFAULT '',
  `v5` varchar(100) NOT NULL DEFAULT '',
  KEY `IDX_casbin_rule_ptype` (`ptype`),
  KEY `IDX_casbin_rule_v0` (`v0`),
  KEY `IDX_casbin_rule_v1` (`v1`),
  KEY `IDX_casbin_rule_v2` (`v2`),
  KEY `IDX_casbin_rule_v3` (`v3`),
  KEY `IDX_casbin_rule_v4` (`v4`),
  KEY `IDX_casbin_rule_v5` (`v5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casbin_rule`
--

LOCK TABLES `casbin_rule` WRITE;
/*!40000 ALTER TABLE `casbin_rule` DISABLE KEYS */;
INSERT INTO `casbin_rule` VALUES ('p','built-in','*','*','*','*','*'),('p','app','*','*','*','*','*'),('p','*','*','POST','/api/signup','*','*'),('p','*','*','GET','/api/get-email-and-phone','*','*'),('p','*','*','POST','/api/login','*','*'),('p','*','*','GET','/api/get-app-login','*','*'),('p','*','*','POST','/api/logout','*','*'),('p','*','*','GET','/api/logout','*','*'),('p','*','*','GET','/api/get-account','*','*'),('p','*','*','GET','/api/userinfo','*','*'),('p','*','*','GET','/api/user','*','*'),('p','*','*','POST','/api/webhook','*','*'),('p','*','*','GET','/api/get-webhook-event','*','*'),('p','*','*','GET','/api/get-captcha-status','*','*'),('p','*','*','*','/api/login/oauth','*','*'),('p','*','*','GET','/api/get-application','*','*'),('p','*','*','GET','/api/get-organization-applications','*','*'),('p','*','*','GET','/api/get-user','*','*'),('p','*','*','GET','/api/get-user-application','*','*'),('p','*','*','GET','/api/get-resources','*','*'),('p','*','*','GET','/api/get-records','*','*'),('p','*','*','GET','/api/get-product','*','*'),('p','*','*','POST','/api/buy-product','*','*'),('p','*','*','GET','/api/get-payment','*','*'),('p','*','*','POST','/api/update-payment','*','*'),('p','*','*','POST','/api/invoice-payment','*','*'),('p','*','*','POST','/api/notify-payment','*','*'),('p','*','*','POST','/api/unlink','*','*'),('p','*','*','POST','/api/set-password','*','*'),('p','*','*','POST','/api/send-verification-code','*','*'),('p','*','*','GET','/api/get-captcha','*','*'),('p','*','*','POST','/api/verify-captcha','*','*'),('p','*','*','POST','/api/verify-code','*','*'),('p','*','*','POST','/api/reset-email-or-phone','*','*'),('p','*','*','POST','/api/upload-resource','*','*'),('p','*','*','GET','/.well-known/openid-configuration','*','*'),('p','*','*','*','/.well-known/jwks','*','*'),('p','*','*','GET','/api/get-saml-login','*','*'),('p','*','*','POST','/api/acs','*','*'),('p','*','*','GET','/api/saml/metadata','*','*'),('p','*','*','*','/cas','*','*'),('p','*','*','*','/api/webauthn','*','*'),('p','*','*','GET','/api/get-release','*','*'),('p','*','*','GET','/api/get-default-application','*','*'),('p','*','*','GET','/api/get-prometheus-info','*','*'),('p','*','*','*','/api/metrics','*','*');
/*!40000 ALTER TABLE `casbin_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cert`
--

DROP TABLE IF EXISTS `cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cert` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `scope` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `crypto_algorithm` varchar(100) DEFAULT NULL,
  `bit_size` int DEFAULT NULL,
  `expire_in_years` int DEFAULT NULL,
  `certificate` mediumtext,
  `private_key` mediumtext,
  `authority_public_key` mediumtext,
  `authority_root_public_key` mediumtext,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cert`
--

LOCK TABLES `cert` WRITE;
/*!40000 ALTER TABLE `cert` DISABLE KEYS */;
INSERT INTO `cert` VALUES ('admin','cert-built-in','2023-06-19T06:55:43Z','Built-in Cert','JWT','x509','RS256',4096,20,'-----BEGIN CERTIFICATE-----\nMIIE3TCCAsWgAwIBAgIDAeJAMA0GCSqGSIb3DQEBCwUAMCgxDjAMBgNVBAoTBWFk\nbWluMRYwFAYDVQQDEw1jZXJ0LWJ1aWx0LWluMB4XDTIzMDYxOTA2NTU0NFoXDTQz\nMDYxOTA2NTU0NFowKDEOMAwGA1UEChMFYWRtaW4xFjAUBgNVBAMTDWNlcnQtYnVp\nbHQtaW4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYIrcethUAx752\nNhGH9yQ6s3jc4Y3m1P57p6AQkoF9t4cQJlpOgk9ju/aulnP5/gxQHV2jaF8aF2Wx\nQ0gSFkmAj/O2mHUjGbvorUEIaxZqfkObbAf0w2HDRmV1QDOjjyTlcNMQVSL1Mew+\nMDPgvIMkAkwYsvmh9lAaA5MP3ZV0WCF7YzMbNUYN69z4r8BFqUWwjPrRO6HUj/sL\nO86igbIvG65qOpuLQQtASWWYaVDTwD+i6yB2dyGp+eHoDwOGnEQ9Epxa+dTbE+QC\n+HQTIwXYzoUOvi/XZ+pGKtPlpnIbz1oiK+WSyVVYWFw5oMMXCPwMBXGxSV9yqCYM\nz75nJHB6aX5Qk8V6M485sJBhGKjBQBjMlPxjGwPrqWFB0jTwDsTTKzm5sLvjHJi9\nZIw+DD/pH/SADQusY6DzhYidWJnhzszcNLThkB89TCKVQIti3gS2ZVO9eeeXpKTk\nsdZ1XjkysO2bGigllz2J4MPr0kalWhOQ1ZujETB2anoHPeRdwH2menYH+jDU+A7x\n6bFXqy5CecpcOJiMudkCNe7xsyMGbfg7WY9ssbjjLeMDDVSqevNflcWd/yqc/lhV\nMKl13TYyytTDTrNw4Hc/DXhm7eQYed2zGDQLH0qrzh0bMWkXe4XU+LV7RjjHL44N\n9wcRDF1ED9BXFw+lyPwDAvXqAaqthQIDAQABoxAwDjAMBgNVHRMBAf8EAjAAMA0G\nCSqGSIb3DQEBCwUAA4ICAQCUiBjCa2XY68IXF8b4KaRtV2DgRjXKVME4o2wvm9de\nQ2pN3F61IA+WEKBZzeSiMfENKnh8cgY3wEMXFeEOopincRvrXR0eNyeg5xTJhv4d\nG7LbAIJ+jmctJZ/jd5+F8naRA9J3RIlSA5WpyyHs/HyagzynIYL8JL34t/Q31CSq\neYCkTfDL79hHBA2jKQPW+TPB27zb3e6WBYzuh0Qb3UJrgeKlsEGPRuJ06bNlDaXA\nHSFMRbLEw5pxuOpL/4wbKDLAGvbY5hPPI4467RuzxakbZ0XlpNR/DpZ8STxX1N3F\n/A90qbwK93ztkue/NjdBNkyHTNSQIbmvEWS9idfekS1Nig5iePhTifaxeCO/nRh2\n1u2WLK6TgTRGHk9kRTsirWkJBSTEXz6tdHgMdaFow1XMr9khq//aBZrYYpZq97fU\noEl3hwSdOGxnSgYkyFKvaLhLIKkS8067AqPs39Q3K8E4oUYOs9OM20lrgU9FwOI+\nCkw8aCeJYYjRSJTYj3bTU4mF3Flw7TCXdLdHHY8yXKpEdv7uyW6BsrSrFO6I4GRb\nMddQrgVhSQh0VReaJcb4PbhiBvjBURrGumsdNof9h2zLoeDpTmNpINqNabqWAgtS\n0wwmgAOrpRICc+SeUEWs4aI+dGHLuAO8MgG8hfdUtksvJiTfnJy0+3CXGfxCru1w\nxw==\n-----END CERTIFICATE-----\n','-----BEGIN RSA PRIVATE KEY-----\n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\n-----END RSA PRIVATE KEY-----\n','','');
/*!40000 ALTER TABLE `cert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `updated_time` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `user1` varchar(100) DEFAULT NULL,
  `user2` varchar(100) DEFAULT NULL,
  `users` varchar(100) DEFAULT NULL,
  `message_count` int DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldap`
--

DROP TABLE IF EXISTS `ldap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ldap` (
  `id` varchar(100) NOT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `server_name` varchar(100) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `enable_ssl` tinyint(1) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `base_dn` varchar(100) DEFAULT NULL,
  `filter` varchar(200) DEFAULT NULL,
  `filter_fields` varchar(100) DEFAULT NULL,
  `auto_sync` int DEFAULT NULL,
  `last_sync` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldap`
--

LOCK TABLES `ldap` WRITE;
/*!40000 ALTER TABLE `ldap` DISABLE KEYS */;
INSERT INTO `ldap` VALUES ('ldap-built-in','built-in','2023-06-19T06:55:45Z','BuildIn LDAP Server','example.com',389,0,'cn=buildin,dc=example,dc=com','123','ou=BuildIn,dc=example,dc=com','','null',0,'');
/*!40000 ALTER TABLE `ldap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `chat` varchar(100) DEFAULT NULL,
  `reply_to` varchar(100) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `text` mediumtext,
  PRIMARY KEY (`owner`,`name`),
  KEY `IDX_message_chat` (`chat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration` (
  `id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('20221015CasbinRule--fill ptype field with p'),('20230209MigratePermissionRule--Use V5 instead of V1 to store permissionID');
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model`
--

DROP TABLE IF EXISTS `model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `model_text` mediumtext,
  `is_enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model`
--

LOCK TABLES `model` WRITE;
/*!40000 ALTER TABLE `model` DISABLE KEYS */;
INSERT INTO `model` VALUES ('built-in','model-built-in','2023-06-19T06:55:43Z','Built-in Model','[request_definition]\nr = sub, obj, act\n\n[policy_definition]\np = sub, obj, act\n\n[policy_effect]\ne = some(where (p.eft == allow))\n\n[matchers]\nm = r.sub == p.sub && r.obj == p.obj && r.act == p.act',1);
/*!40000 ALTER TABLE `model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `website_url` varchar(100) DEFAULT NULL,
  `favicon` varchar(100) DEFAULT NULL,
  `password_type` varchar(100) DEFAULT NULL,
  `password_salt` varchar(100) DEFAULT NULL,
  `country_codes` varchar(200) DEFAULT NULL,
  `default_avatar` varchar(200) DEFAULT NULL,
  `default_application` varchar(100) DEFAULT NULL,
  `tags` mediumtext,
  `languages` varchar(255) DEFAULT NULL,
  `theme_data` text,
  `master_password` varchar(100) DEFAULT NULL,
  `init_score` int DEFAULT NULL,
  `enable_soft_deletion` tinyint(1) DEFAULT NULL,
  `is_profile_public` tinyint(1) DEFAULT NULL,
  `mfa_items` varchar(300) DEFAULT NULL,
  `account_items` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES ('admin','built-in','2023-06-19T06:55:43Z','Built-in Organization','https://example.com','https://cdn.casbin.org/img/casbin/favicon.ico','plain','','[\"US\",\"ES\",\"CN\",\"FR\",\"DE\",\"GB\",\"JP\",\"KR\",\"VN\",\"ID\",\"SG\",\"IN\"]','https://cdn.casbin.org/img/casbin.svg','','[]','[\"en\",\"zh\",\"es\",\"fr\",\"de\",\"id\",\"ja\",\"ko\",\"ru\",\"vi\",\"pt\"]',NULL,'',2000,0,0,'null','[{\"name\":\"Organization\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"ID\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Display name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Avatar\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"User type\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Password\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Email\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Phone\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Country code\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Country/Region\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Location\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Affiliation\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Title\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Homepage\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Bio\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Tag\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Signup application\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Roles\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Permissions\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"3rd-party logins\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Properties\",\"visible\":false,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is global admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is forbidden\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is deleted\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Multi-factor authentication\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"WebAuthn credentials\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Managed accounts\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"}]'),('admin','dev','2023-06-19T19:08:55+08:00','开发测试组','https://door.casdoor.com','https://cdn.casbin.org/img/favicon.png','salt','YH9A611gN9YJE3kJ7ANU279VAO0W1HG3','[\"CN\"]','https://cdn.casbin.org/img/casbin.svg','','[]','[\"en\",\"zh\",\"es\",\"fr\",\"de\",\"id\",\"ja\",\"ko\",\"ru\",\"vi\"]',NULL,'',0,0,1,NULL,'[{\"name\":\"Organization\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"ID\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Display name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Avatar\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"User type\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Password\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Email\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Phone\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Country/Region\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Location\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Affiliation\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Title\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Homepage\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Bio\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Tag\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Signup application\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Roles\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Permissions\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"3rd-party logins\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Properties\",\"visible\":false,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is global admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is forbidden\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is deleted\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"}]');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `product_display_name` varchar(100) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `currency` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `pay_url` varchar(2000) DEFAULT NULL,
  `return_url` varchar(1000) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `message` varchar(2000) DEFAULT NULL,
  `person_name` varchar(100) DEFAULT NULL,
  `person_id_card` varchar(100) DEFAULT NULL,
  `person_email` varchar(100) DEFAULT NULL,
  `person_phone` varchar(100) DEFAULT NULL,
  `invoice_type` varchar(100) DEFAULT NULL,
  `invoice_title` varchar(100) DEFAULT NULL,
  `invoice_tax_id` varchar(100) DEFAULT NULL,
  `invoice_remark` varchar(100) DEFAULT NULL,
  `invoice_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `users` mediumtext,
  `roles` mediumtext,
  `domains` mediumtext,
  `model` varchar(100) DEFAULT NULL,
  `adapter` varchar(100) DEFAULT NULL,
  `resource_type` varchar(100) DEFAULT NULL,
  `resources` mediumtext,
  `actions` mediumtext,
  `effect` varchar(100) DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT NULL,
  `submitter` varchar(100) DEFAULT NULL,
  `approver` varchar(100) DEFAULT NULL,
  `approve_time` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES ('built-in','permission-built-in','2023-06-19T06:55:43Z','Built-in Permission','[\"built-in/*\"]','[]','[]','model-built-in','','Application','[\"app-built-in\"]','[\"Read\",\"Write\",\"Admin\"]','Allow',1,'','','','');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_rule`
--

DROP TABLE IF EXISTS `permission_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_rule` (
  `ptype` varchar(100) NOT NULL DEFAULT '',
  `v0` varchar(100) NOT NULL DEFAULT '',
  `v1` varchar(100) NOT NULL DEFAULT '',
  `v2` varchar(100) NOT NULL DEFAULT '',
  `v3` varchar(100) NOT NULL DEFAULT '',
  `v4` varchar(100) NOT NULL DEFAULT '',
  `v5` varchar(100) NOT NULL DEFAULT '',
  `id` varchar(100) NOT NULL DEFAULT '',
  KEY `IDX_permission_rule_v2` (`v2`),
  KEY `IDX_permission_rule_v3` (`v3`),
  KEY `IDX_permission_rule_v4` (`v4`),
  KEY `IDX_permission_rule_v5` (`v5`),
  KEY `IDX_permission_rule_ptype` (`ptype`),
  KEY `IDX_permission_rule_v0` (`v0`),
  KEY `IDX_permission_rule_v1` (`v1`),
  KEY `IDX_permission_rule_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_rule`
--

LOCK TABLES `permission_rule` WRITE;
/*!40000 ALTER TABLE `permission_rule` DISABLE KEYS */;
INSERT INTO `permission_rule` VALUES ('p','built-in/*','app-built-in','read','','','built-in/permission-built-in',''),('p','built-in/*','app-built-in','write','','','built-in/permission-built-in',''),('p','built-in/*','app-built-in','admin','','','built-in/permission-built-in','');
/*!40000 ALTER TABLE `permission_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `price_per_month` double DEFAULT NULL,
  `price_per_year` double DEFAULT NULL,
  `currency` varchar(100) DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan`
--

LOCK TABLES `plan` WRITE;
/*!40000 ALTER TABLE `plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing`
--

DROP TABLE IF EXISTS `pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `plans` mediumtext,
  `is_enabled` tinyint(1) DEFAULT NULL,
  `has_trial` tinyint(1) DEFAULT NULL,
  `trial_duration` int DEFAULT NULL,
  `application` varchar(100) DEFAULT NULL,
  `submitter` varchar(100) DEFAULT NULL,
  `approver` varchar(100) DEFAULT NULL,
  `approve_time` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing`
--

LOCK TABLES `pricing` WRITE;
/*!40000 ALTER TABLE `pricing` DISABLE KEYS */;
/*!40000 ALTER TABLE `pricing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `currency` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `sold` int DEFAULT NULL,
  `providers` varchar(100) DEFAULT NULL,
  `return_url` varchar(1000) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `sub_type` varchar(100) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `client_id` varchar(100) DEFAULT NULL,
  `client_secret` varchar(2000) DEFAULT NULL,
  `client_id2` varchar(100) DEFAULT NULL,
  `client_secret2` varchar(100) DEFAULT NULL,
  `cert` varchar(100) DEFAULT NULL,
  `custom_auth_url` varchar(200) DEFAULT NULL,
  `custom_scope` varchar(200) DEFAULT NULL,
  `custom_token_url` varchar(200) DEFAULT NULL,
  `custom_user_info_url` varchar(200) DEFAULT NULL,
  `custom_logo` varchar(200) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `disable_ssl` tinyint(1) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `region_id` varchar(100) DEFAULT NULL,
  `sign_name` varchar(100) DEFAULT NULL,
  `template_code` varchar(100) DEFAULT NULL,
  `app_id` varchar(100) DEFAULT NULL,
  `endpoint` varchar(1000) DEFAULT NULL,
  `intranet_endpoint` varchar(100) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `bucket` varchar(100) DEFAULT NULL,
  `path_prefix` varchar(100) DEFAULT NULL,
  `metadata` mediumtext,
  `id_p` mediumtext,
  `issuer_url` varchar(100) DEFAULT NULL,
  `enable_sign_authn_request` tinyint(1) DEFAULT NULL,
  `provider_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`),
  UNIQUE KEY `UQE_provider_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES ('admin','mockamail','2023-06-19T14:56:24+08:00','模拟邮件','Email','SUBMAIL','','Normal','test@mailhog.example','','','','','','','','','','smtp.',1025,1,'Casdoor Verification Code','You have requested a verification code at Casdoor. Here is your code: %s, please enter in 5 minutes.','admin@example.com','','','','','','','','','','','','',0,'https://github.com/organizations/xxx/settings/applications/1234567'),('admin','provider_captcha_default','2023-06-19T06:55:43Z','Captcha Default','Captcha','Default','','','','','','','','','','','','','',0,0,'','','','','','','','','','','','','','','',0,'');
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `client_ip` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `request_uri` varchar(1000) DEFAULT NULL,
  `action` varchar(1000) DEFAULT NULL,
  `is_triggered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_record_owner` (`owner`),
  KEY `IDX_record_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(180) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `application` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `parent` varchar(100) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `file_format` varchar(100) DEFAULT NULL,
  `file_size` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `users` mediumtext,
  `roles` mediumtext,
  `domains` mediumtext,
  `is_enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `application` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `session_id` text,
  PRIMARY KEY (`owner`,`name`,`application`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `plan` varchar(100) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `user` mediumtext,
  `is_enabled` tinyint(1) DEFAULT NULL,
  `submitter` varchar(100) DEFAULT NULL,
  `approver` varchar(100) DEFAULT NULL,
  `approve_time` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syncer`
--

DROP TABLE IF EXISTS `syncer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `syncer` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `database_type` varchar(100) DEFAULT NULL,
  `database` varchar(100) DEFAULT NULL,
  `table` varchar(100) DEFAULT NULL,
  `table_primary_key` varchar(100) DEFAULT NULL,
  `table_columns` mediumtext,
  `affiliation_table` varchar(100) DEFAULT NULL,
  `avatar_base_url` varchar(100) DEFAULT NULL,
  `error_text` mediumtext,
  `sync_interval` int DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syncer`
--

LOCK TABLES `syncer` WRITE;
/*!40000 ALTER TABLE `syncer` DISABLE KEYS */;
/*!40000 ALTER TABLE `syncer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `application` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `access_token` mediumtext,
  `refresh_token` mediumtext,
  `expires_in` int DEFAULT NULL,
  `scope` varchar(100) DEFAULT NULL,
  `token_type` varchar(100) DEFAULT NULL,
  `code_challenge` varchar(100) DEFAULT NULL,
  `code_is_used` tinyint(1) DEFAULT NULL,
  `code_expire_in` bigint DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`),
  KEY `IDX_token_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `updated_time` varchar(100) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `password_salt` varchar(100) DEFAULT NULL,
  `password_type` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `permanent_avatar` varchar(500) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country_code` varchar(6) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `address` text,
  `affiliation` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `id_card_type` varchar(100) DEFAULT NULL,
  `id_card` varchar(100) DEFAULT NULL,
  `homepage` varchar(100) DEFAULT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `language` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `birthday` varchar(100) DEFAULT NULL,
  `education` varchar(100) DEFAULT NULL,
  `score` int DEFAULT NULL,
  `karma` int DEFAULT NULL,
  `ranking` int DEFAULT NULL,
  `is_default_avatar` tinyint(1) DEFAULT NULL,
  `is_online` tinyint(1) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `is_global_admin` tinyint(1) DEFAULT NULL,
  `is_forbidden` tinyint(1) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `signup_application` varchar(100) DEFAULT NULL,
  `hash` varchar(100) DEFAULT NULL,
  `pre_hash` varchar(100) DEFAULT NULL,
  `created_ip` varchar(100) DEFAULT NULL,
  `last_signin_time` varchar(100) DEFAULT NULL,
  `last_signin_ip` varchar(100) DEFAULT NULL,
  `github` varchar(100) DEFAULT NULL,
  `google` varchar(100) DEFAULT NULL,
  `qq` varchar(100) DEFAULT NULL,
  `wechat` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `dingtalk` varchar(100) DEFAULT NULL,
  `weibo` varchar(100) DEFAULT NULL,
  `gitee` varchar(100) DEFAULT NULL,
  `linkedin` varchar(100) DEFAULT NULL,
  `wecom` varchar(100) DEFAULT NULL,
  `lark` varchar(100) DEFAULT NULL,
  `gitlab` varchar(100) DEFAULT NULL,
  `adfs` varchar(100) DEFAULT NULL,
  `baidu` varchar(100) DEFAULT NULL,
  `alipay` varchar(100) DEFAULT NULL,
  `casdoor` varchar(100) DEFAULT NULL,
  `infoflow` varchar(100) DEFAULT NULL,
  `apple` varchar(100) DEFAULT NULL,
  `azuread` varchar(100) DEFAULT NULL,
  `slack` varchar(100) DEFAULT NULL,
  `steam` varchar(100) DEFAULT NULL,
  `bilibili` varchar(100) DEFAULT NULL,
  `okta` varchar(100) DEFAULT NULL,
  `douyin` varchar(100) DEFAULT NULL,
  `line` varchar(100) DEFAULT NULL,
  `amazon` varchar(100) DEFAULT NULL,
  `auth0` varchar(100) DEFAULT NULL,
  `battlenet` varchar(100) DEFAULT NULL,
  `bitbucket` varchar(100) DEFAULT NULL,
  `box` varchar(100) DEFAULT NULL,
  `cloudfoundry` varchar(100) DEFAULT NULL,
  `dailymotion` varchar(100) DEFAULT NULL,
  `deezer` varchar(100) DEFAULT NULL,
  `digitalocean` varchar(100) DEFAULT NULL,
  `discord` varchar(100) DEFAULT NULL,
  `dropbox` varchar(100) DEFAULT NULL,
  `eveonline` varchar(100) DEFAULT NULL,
  `fitbit` varchar(100) DEFAULT NULL,
  `gitea` varchar(100) DEFAULT NULL,
  `heroku` varchar(100) DEFAULT NULL,
  `influxcloud` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `intercom` varchar(100) DEFAULT NULL,
  `kakao` varchar(100) DEFAULT NULL,
  `lastfm` varchar(100) DEFAULT NULL,
  `mailru` varchar(100) DEFAULT NULL,
  `meetup` varchar(100) DEFAULT NULL,
  `microsoftonline` varchar(100) DEFAULT NULL,
  `naver` varchar(100) DEFAULT NULL,
  `nextcloud` varchar(100) DEFAULT NULL,
  `onedrive` varchar(100) DEFAULT NULL,
  `oura` varchar(100) DEFAULT NULL,
  `patreon` varchar(100) DEFAULT NULL,
  `paypal` varchar(100) DEFAULT NULL,
  `salesforce` varchar(100) DEFAULT NULL,
  `shopify` varchar(100) DEFAULT NULL,
  `soundcloud` varchar(100) DEFAULT NULL,
  `spotify` varchar(100) DEFAULT NULL,
  `strava` varchar(100) DEFAULT NULL,
  `stripe` varchar(100) DEFAULT NULL,
  `tiktok` varchar(100) DEFAULT NULL,
  `tumblr` varchar(100) DEFAULT NULL,
  `twitch` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `typetalk` varchar(100) DEFAULT NULL,
  `uber` varchar(100) DEFAULT NULL,
  `vk` varchar(100) DEFAULT NULL,
  `wepay` varchar(100) DEFAULT NULL,
  `xero` varchar(100) DEFAULT NULL,
  `yahoo` varchar(100) DEFAULT NULL,
  `yammer` varchar(100) DEFAULT NULL,
  `yandex` varchar(100) DEFAULT NULL,
  `zoom` varchar(100) DEFAULT NULL,
  `custom` varchar(100) DEFAULT NULL,
  `webauthnCredentials` blob,
  `multi_factor_auths` text,
  `ldap` varchar(100) DEFAULT NULL,
  `properties` text,
  `roles` text,
  `permissions` text,
  `last_signin_wrong_time` varchar(100) DEFAULT NULL,
  `signin_wrong_times` int DEFAULT NULL,
  `managedAccounts` blob,
  PRIMARY KEY (`owner`,`name`),
  KEY `IDX_user_id` (`id`),
  KEY `IDX_user_email` (`email`),
  KEY `IDX_user_phone` (`phone`),
  KEY `IDX_user_id_card` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('built-in','admin','2023-06-19T06:55:43Z','','32cf3423-b9cd-40a1-8c0f-4abe96b18469','normal-user','123','','plain','Admin','','','https://cdn.casbin.org/img/casbin.svg','','admin@example.com',0,'12345678910','CN','','','[]','Example Inc.','','','','','','staff','','','','',2000,0,1,0,0,1,1,0,0,'app-built-in','','','127.0.0.1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',_binary 'null','null','','{}','null','null','',0,_binary 'null');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_record`
--

DROP TABLE IF EXISTS `verification_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_record` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `remote_addr` varchar(100) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `user` varchar(100) NOT NULL,
  `provider` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `time` bigint NOT NULL,
  `is_used` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_record`
--

LOCK TABLES `verification_record` WRITE;
/*!40000 ALTER TABLE `verification_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `verification_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook`
--

DROP TABLE IF EXISTS `webhook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_time` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `content_type` varchar(100) DEFAULT NULL,
  `headers` mediumtext,
  `events` varchar(1000) DEFAULT NULL,
  `is_user_extended` tinyint(1) DEFAULT NULL,
  `is_enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`),
  KEY `IDX_webhook_organization` (`organization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook`
--

LOCK TABLES `webhook` WRITE;
/*!40000 ALTER TABLE `webhook` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-19 12:00:46
