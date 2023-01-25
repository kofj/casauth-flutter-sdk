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
  `logo` varchar(100) DEFAULT NULL,
  `homepage_url` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `cert` varchar(100) DEFAULT NULL,
  `enable_password` tinyint(1) DEFAULT NULL,
  `enable_sign_up` tinyint(1) DEFAULT NULL,
  `enable_signin_session` tinyint(1) DEFAULT NULL,
  `enable_code_signin` tinyint(1) DEFAULT NULL,
  `enable_saml_compress` tinyint(1) DEFAULT NULL,
  `enable_web_authn` tinyint(1) DEFAULT NULL,
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
  `form_css` text,
  `form_offset` int DEFAULT NULL,
  `form_background_url` varchar(200) DEFAULT NULL,
  `enable_auto_signin` tinyint(1) DEFAULT NULL,
  `saml_reply_url` varchar(100) DEFAULT NULL,
  `form_side_html` mediumtext,
  `enable_link_with_email` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES ('admin','app-built-in','2022-08-07T15:24:15Z','Casdoor','https://cdn.casbin.com/logo/logo_1024x256.png','https://casdoor.org','','built-in','cert-built-in',1,1,0,0,0,0,'[{\"name\":\"provider_captcha_default\",\"canSignUp\":false,\"canSignIn\":false,\"canUnlink\":false,\"prompted\":false,\"alertType\":\"None\",\"provider\":null}]','[{\"name\":\"ID\",\"visible\":false,\"required\":true,\"prompted\":false,\"rule\":\"Random\"},{\"name\":\"Username\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Display name\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Password\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Confirm password\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Email\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"Normal\"},{\"name\":\"Phone\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Agreement\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"}]','null','793fe6e63fd99e2707d7','de608371ce2d9ef92cea07646d625d1bf0d45c8a','[]','',168,0,'','','','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('admin','testapp','2022-08-07T23:27:44+08:00','测试应用','https://cdn.casdoor.com/logo/casdoor-logo_1185x256.png','','','dev','cert-built-in',1,1,1,1,0,0,'[{\"name\":\"provider_captcha_default\",\"canSignUp\":false,\"canSignIn\":false,\"canUnlink\":false,\"prompted\":false,\"alertType\":\"None\",\"provider\":null},{\"name\":\"mocksms\",\"canSignUp\":true,\"canSignIn\":true,\"canUnlink\":true,\"prompted\":false,\"alertType\":\"None\",\"provider\":null},{\"name\":\"mockmail\",\"canSignUp\":true,\"canSignIn\":true,\"canUnlink\":true,\"prompted\":false,\"alertType\":\"None\",\"provider\":null}]','[{\"name\":\"ID\",\"visible\":false,\"required\":true,\"prompted\":false,\"rule\":\"Incremental\"},{\"name\":\"Username\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Display name\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Password\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Confirm password\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Email\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"Normal\"},{\"name\":\"Phone\",\"visible\":true,\"required\":false,\"prompted\":false,\"rule\":\"None\"},{\"name\":\"Agreement\",\"visible\":true,\"required\":true,\"prompted\":false,\"rule\":\"None\"}]','[\"authorization_code\",\"password\",\"token\",\"id_token\",\"refresh_token\"]','dc4b4df2fcfa9d2ef765','e895642459c716cf4b969ae197a023e330e8a31a','[\"http://localhost:8000/\"]','JWT',168,0,'','','','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
  KEY `IDX_casbin_rule_v2` (`v2`),
  KEY `IDX_casbin_rule_v3` (`v3`),
  KEY `IDX_casbin_rule_v4` (`v4`),
  KEY `IDX_casbin_rule_v5` (`v5`),
  KEY `IDX_casbin_rule_ptype` (`ptype`),
  KEY `IDX_casbin_rule_v0` (`v0`),
  KEY `IDX_casbin_rule_v1` (`v1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casbin_rule`
--

LOCK TABLES `casbin_rule` WRITE;
/*!40000 ALTER TABLE `casbin_rule` DISABLE KEYS */;
INSERT INTO `casbin_rule` VALUES ('p','built-in','*','*','*','*','*'),('p','app','*','*','*','*','*'),('p','*','*','POST','/api/signup','*','*'),('p','*','*','POST','/api/get-email-and-phone','*','*'),('p','*','*','POST','/api/login','*','*'),('p','*','*','GET','/api/get-app-login','*','*'),('p','*','*','POST','/api/logout','*','*'),('p','*','*','GET','/api/logout','*','*'),('p','*','*','GET','/api/get-account','*','*'),('p','*','*','GET','/api/userinfo','*','*'),('p','*','*','POST','/api/webhook','*','*'),('p','*','*','GET','/api/get-webhook-event','*','*'),('p','*','*','*','/api/login/oauth','*','*'),('p','*','*','GET','/api/get-application','*','*'),('p','*','*','GET','/api/get-organization-applications','*','*'),('p','*','*','GET','/api/get-user','*','*'),('p','*','*','GET','/api/get-user-application','*','*'),('p','*','*','GET','/api/get-resources','*','*'),('p','*','*','GET','/api/get-records','*','*'),('p','*','*','GET','/api/get-product','*','*'),('p','*','*','POST','/api/buy-product','*','*'),('p','*','*','GET','/api/get-payment','*','*'),('p','*','*','POST','/api/update-payment','*','*'),('p','*','*','POST','/api/invoice-payment','*','*'),('p','*','*','POST','/api/notify-payment','*','*'),('p','*','*','POST','/api/unlink','*','*'),('p','*','*','POST','/api/set-password','*','*'),('p','*','*','POST','/api/send-verification-code','*','*'),('p','*','*','GET','/api/get-captcha','*','*'),('p','*','*','POST','/api/verify-captcha','*','*'),('p','*','*','POST','/api/reset-email-or-phone','*','*'),('p','*','*','POST','/api/upload-resource','*','*'),('p','*','*','GET','/.well-known/openid-configuration','*','*'),('p','*','*','*','/.well-known/jwks','*','*'),('p','*','*','GET','/api/get-saml-login','*','*'),('p','*','*','POST','/api/acs','*','*'),('p','*','*','GET','/api/saml/metadata','*','*'),('p','*','*','*','/cas','*','*'),('p','*','*','*','/api/webauthn','*','*'),('p','*','*','GET','/api/get-release','*','*'),('p','*','*','GET','/api/get-default-application','*','*');
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
INSERT INTO `cert` VALUES ('admin','cert-built-in','2022-08-07T15:24:15Z','Built-in Cert','JWT','x509','RS256',4096,20,'-----BEGIN CERTIFICATE-----\nMIIE3TCCAsWgAwIBAgIDAeJAMA0GCSqGSIb3DQEBCwUAMCgxDjAMBgNVBAoTBWFk\nbWluMRYwFAYDVQQDEw1jZXJ0LWJ1aWx0LWluMB4XDTIyMDgwNzE1MjQxNloXDTQy\nMDgwNzE1MjQxNlowKDEOMAwGA1UEChMFYWRtaW4xFjAUBgNVBAMTDWNlcnQtYnVp\nbHQtaW4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDq0nK5YzWM0StI\n12vNcABqPUI70zn/oiv1m6h64eCFDO/oAxmf+Cn3Ek/e4GPK1QbUaQKa6f93YAVd\nzTDjYsQMr3sipHFG8ls4+Hq9AJ1CpLggI8eDchVHXpdSouMUIlHEJmVizEw/OAJs\nqBo7mgklJ9yj8rY+jGL2wDzaAv1y0bBttXHxc59h+1NILkvV63lrgOPpQ5vYOVcz\nFwn6Ueox9q6DOqbCHO3grYypJKdCw1jzLlVgbBY5rXjGv09et7ufJcvikJqCyJYy\nsbjwmjPaeQucZNOsJ+n5Bxq5GUcuo+h7Pq0j9P6RKJdc2aqMa4+3eiokOqiIHQPA\n11Cd0hRAsTl1+oRD7U/WO91AwM8jWRS7BDKMHEAfqSBgHX+/lJulpHnku+iS7zv8\nsBJ6w+ibouZH4/CCS9y7j9HIvsh5Cf6ZbLUdo4VxEP5NcIXo6XF32olhZVFwj1ON\nvpM9Z8RI5iDlljfsOCVsyx7lnH11a9VAs9QHn6DRfESODISZx7/Ftfi6FUUfplcM\nN7xcQe1V6qxrewvjqnKU/Rksph5IeffNQGwxOywfIb+Nhpxvr1zDlRfCv7UW4bBN\nf9Z/LtZxJ3RyiSplDDZFPovvxpaU2P7lHKJEpfWKmYDWPrPHlDDbEhrwunQvaxwa\nSAfJSTY1zhkE7ifn0zux4VFtfjtsAwIDAQABoxAwDjAMBgNVHRMBAf8EAjAAMA0G\nCSqGSIb3DQEBCwUAA4ICAQAVVI3c9qCOZrxp8S3amFY5XGRMMvca1JrFtLnaRWD0\nGTHdkOEzvB7Pz9+NYSPGcurx+lRM4dKx9uCXye8zKhQP/tny5sPJC/fZvc8YZ6Bv\nfU/OYA1jI3SfHmWbG80p1BZ0QWJQc16R/CP+4HO2bceAY5Hg1SxkkC5+uc3v1dA/\nyrBrjKY2Atq/G5y5mDOV/iXnsDfh74n2x/+aZ4PewdZwwI7ySZTmK8EkuUvh2ubC\nVzFZM8RuUdeQgKlGlr83duxObz8OFmuLoUYaOW8EsYsoVFd8O50t1BHf/aXAAX6h\nj7FMlcLkE/YWHQCh1ist0ZHplHC+Gp2HY/hzQzAY3fyX5GAtZeUXkq7Uv/nKOUZV\nDIliCYmfacht2cQhjVvc3gTx390HejXWGJOUOplCMdMQsm9laDGDLZjCo+a4Bi1X\nGm+c4dyJzpNFH1KwigjWImY3g5Iq4l/zkTLj+D3i3bkj6lqe7VdvXu3UcErnePpE\n8rOuyXZ2332gAtGW7QD9KWlPmaNIOQZHaTxTl6xV5CdqDkjQdkcB+DRH5Apx7Bvw\nSCeOYOUENPQsEi5SK3oq36Z8GQHuWCJVbK12A59QAu+lZ6tXsAvp82aq7pJl8cme\nffBe+ake7N0AyrzSEfQoLbE4c8I8CZD1vuvTC3SBqdULCceJpjnxeDakYNwGjVmo\n6w==\n-----END CERTIFICATE-----\n','-----BEGIN PRIVATE KEY-----\n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\n-----END PRIVATE KEY-----\n','','');
/*!40000 ALTER TABLE `cert` ENABLE KEYS */;
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
  `admin` varchar(100) DEFAULT NULL,
  `passwd` varchar(100) DEFAULT NULL,
  `base_dn` varchar(100) DEFAULT NULL,
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
INSERT INTO `ldap` VALUES ('ldap-built-in','built-in','2022-08-07T15:24:16Z','BuildIn LDAP Server','example.com',389,'cn=buildin,dc=example,dc=com','123','ou=BuildIn,dc=example,dc=com',0,'');
/*!40000 ALTER TABLE `ldap` ENABLE KEYS */;
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
  `phone_prefix` varchar(10) DEFAULT NULL,
  `default_avatar` varchar(100) DEFAULT NULL,
  `tags` mediumtext,
  `master_password` varchar(100) DEFAULT NULL,
  `enable_soft_deletion` tinyint(1) DEFAULT NULL,
  `is_profile_public` tinyint(1) DEFAULT NULL,
  `account_items` varchar(3000) DEFAULT NULL,
  `default_application` varchar(100) DEFAULT NULL,
  `languages` varchar(255) DEFAULT NULL,
  `init_score` int DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES ('admin','built-in','2022-08-07T15:24:15Z','Built-in Organization','https://example.com','https://cdn.casbin.com/static/favicon.ico','plain','','86','https://casbin.org/img/casbin.svg','[]','',0,0,'[{\"name\":\"Organization\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"ID\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Display name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Avatar\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"User type\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Password\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Email\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Phone\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Country/Region\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Location\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Affiliation\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Title\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Homepage\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Bio\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Tag\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Signup application\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Roles\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Permissions\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"3rd-party logins\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Properties\",\"visible\":false,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is global admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is forbidden\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is deleted\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"WebAuthn credentials\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"}]',NULL,NULL,NULL),('admin','dev','2022-08-07T23:28:07+08:00','测试环境','https://door.casdoor.com','https://cdn.casdoor.com/static/favicon.png','bcrypt','','86','https://casbin.org/img/casbin.svg','[]','',0,1,'[{\"name\":\"Organization\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"ID\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Display name\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Avatar\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"User type\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Password\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Email\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Phone\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Country/Region\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Location\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Affiliation\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Title\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Homepage\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Bio\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Self\"},{\"name\":\"Tag\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Signup application\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Admin\"},{\"name\":\"Roles\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"Permissions\",\"visible\":true,\"viewRule\":\"Public\",\"modifyRule\":\"Immutable\"},{\"name\":\"3rd-party logins\",\"visible\":true,\"viewRule\":\"Self\",\"modifyRule\":\"Self\"},{\"name\":\"Properties\",\"visible\":false,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is global admin\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is forbidden\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"},{\"name\":\"Is deleted\",\"visible\":true,\"viewRule\":\"Admin\",\"modifyRule\":\"Admin\"}]',NULL,NULL,NULL);
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
  `message` varchar(1000) DEFAULT NULL,
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
  KEY `IDX_permission_rule_v3` (`v3`),
  KEY `IDX_permission_rule_v4` (`v4`),
  KEY `IDX_permission_rule_v5` (`v5`),
  KEY `IDX_permission_rule_id` (`id`),
  KEY `IDX_permission_rule_ptype` (`ptype`),
  KEY `IDX_permission_rule_v0` (`v0`),
  KEY `IDX_permission_rule_v1` (`v1`),
  KEY `IDX_permission_rule_v2` (`v2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_rule`
--

LOCK TABLES `permission_rule` WRITE;
/*!40000 ALTER TABLE `permission_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_rule` ENABLE KEYS */;
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
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `region_id` varchar(100) DEFAULT NULL,
  `sign_name` varchar(100) DEFAULT NULL,
  `template_code` varchar(100) DEFAULT NULL,
  `app_id` varchar(100) DEFAULT NULL,
  `endpoint` varchar(1000) DEFAULT NULL,
  `intranet_endpoint` varchar(100) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `bucket` varchar(100) DEFAULT NULL,
  `metadata` mediumtext,
  `id_p` mediumtext,
  `issuer_url` varchar(100) DEFAULT NULL,
  `enable_sign_authn_request` tinyint(1) DEFAULT NULL,
  `provider_url` varchar(200) DEFAULT NULL,
  `disable_ssl` tinyint(1) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `path_prefix` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`),
  UNIQUE KEY `UQE_provider_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES ('admin','mockmail','2022-08-13T12:26:59+08:00','模拟邮件','Email','SUBMAIL','','Normal','test@mailhog.example','','','','','','','','','','smtp',1025,'Code','verification code: %s, please enter in 5 minutes.','','','','','','','','','','','',0,'',1,NULL,NULL),('admin','mocksms','2022-08-10T18:25:17+08:00','模拟短信','SMS','Mock SMS','','Normal','ak','sk','','','','','','','','','',0,'','','','sign','124','abc','','','','','','','',0,'https://github.com/organizations/xxx/settings/applications/1234567',NULL,NULL,NULL),('admin','provider_captcha_default','2022-08-07T15:24:15Z','Captcha Default','Captcha','','','','','','','','','','','','','','',0,'','','','','','','','','','','','','',0,'',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource` (
  `owner` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
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
  `created_time` varchar(100) DEFAULT NULL,
  `session_id` text,
  PRIMARY KEY (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('built-in','admin','2023-01-10T03:33:57Z','[\"e355d9b956def7d46fdedfe0322af7b1\"]');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
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
  PRIMARY KEY (`owner`,`name`)
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
  `display_name` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `permanent_avatar` varchar(500) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `address` text,
  `affiliation` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `id_card_type` varchar(100) DEFAULT NULL,
  `id_card` varchar(100) DEFAULT NULL,
  `homepage` varchar(100) DEFAULT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
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
  `we_chat_union_id` varchar(100) DEFAULT NULL,
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
  `custom` varchar(100) DEFAULT NULL,
  `webauthnCredentials` blob,
  `ldap` varchar(100) DEFAULT NULL,
  `properties` text,
  `roles` text,
  `permissions` text,
  `last_signin_wrong_time` varchar(100) DEFAULT NULL,
  `signin_wrong_times` int DEFAULT NULL,
  `managedAccounts` blob,
  `line` varchar(100) DEFAULT NULL,
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
INSERT INTO `user` VALUES ('built-in','admin','2022-08-07T15:24:15Z','','9625cac0-e6ca-4f3b-b49e-69f8e68710ff','normal-user','123','','Admin','','','https://casbin.org/img/casbin.svg','','admin@example.com',0,'12345678910','','[]','Example Inc.','','','','','','staff','','','','','',2000,0,1,0,0,1,1,0,0,'app-built-in','','','127.0.0.1','','','','','','','','','','','','','','','','','','','','','','','','','','','','',_binary 'null','','{}','null','null',NULL,NULL,NULL,NULL),('dev','user_m11zjg','2022-08-07T23:31:36+08:00','','1001','normal-user','$2a$10$4ygPgnQEXDK9uNsi59FCbeV/2/Dl1vOW17s0EUFFLGgzHhyeQyNYS','','测试用户m11zjg','','','https://casbin.org/img/casbin.svg','','m11zjg@example.com',0,'18888888888','','[]','Example Inc.','','','','','','staff','','','','','',0,0,2,0,0,0,0,0,0,'testapp','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',_binary 'null','','{}','null','null',NULL,NULL,NULL,NULL),('dev','user_UIj8pa','2022-08-07T23:32:36+08:00','','1002','normal-user','$2a$10$CoEFly82vtzVcGttYJtdEe4SxJryJwIYA63e60VkWrU4RN8S7POIC','','测试用户UIj8pa','','','https://casbin.org/img/casbin.svg','','UIj8pa@example.com',0,'27327567960','','[]','Example Inc.','','','','','','staff','','','','','',0,0,2,0,0,0,0,0,0,'testapp','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',_binary 'null','','{}','null','null',NULL,NULL,NULL,NULL),('dev','user_vOWUTA','2022-08-07T23:33:36+08:00','','1003','normal-user','$2a$10$UwRL7Z.5I6PQiMDe/d/NHO94A77IQGHq4PJ3jBO5wGnzFSZnQQiwa','','测试用户vOWUTA','','','https://casbin.org/img/casbin.svg','','vOWUTA@example.com',0,'27327567961','','[]','Example Inc.','','','','','','staff','','','','','',0,0,2,0,0,0,0,0,0,'testapp','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',_binary 'null','','{}','null','null',NULL,NULL,NULL,NULL);
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

-- Dump completed on 2023-01-19 15:39:24
