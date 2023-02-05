-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tpigl
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tpigl
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tpigl` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `tpigl` ;

-- -----------------------------------------------------
-- Table `tpigl`.`annonces_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_contact` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(254) NOT NULL,
  `nom` VARCHAR(255) NOT NULL,
  `prenom` VARCHAR(255) NOT NULL,
  `adresse` VARCHAR(255) NOT NULL,
  `numero_telephone` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_localisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_localisation` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `wilaya` VARCHAR(255) NOT NULL,
  `commune` VARCHAR(255) NOT NULL,
  `adresse` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 34
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_annonces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_annonces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(255) NOT NULL,
  `date` DATE NOT NULL,
  `surface` DOUBLE NOT NULL,
  `description` LONGTEXT NOT NULL,
  `prix` DECIMAL(10,2) NOT NULL,
  `categorie` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `imageprincip` VARCHAR(100) NOT NULL,
  `contact_id` BIGINT NULL DEFAULT NULL,
  `localisation_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `localisation_id` (`localisation_id` ASC) VISIBLE,
  INDEX `Annonces_annonces_contact_id_1a9b7c4d_fk_Annonces_contact_id` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `Annonces_annonces_contact_id_1a9b7c4d_fk_Annonces_contact_id`
    FOREIGN KEY (`contact_id`)
    REFERENCES `tpigl`.`annonces_contact` (`id`),
  CONSTRAINT `Annonces_annonces_localisation_id_1d33f707_fk_Annonces_`
    FOREIGN KEY (`localisation_id`)
    REFERENCES `tpigl`.`annonces_localisation` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 40
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_categorie_annonce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_categorie_annonce` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `categorie` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_wilaya`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_wilaya` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `wilaya` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 59
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_commune`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_commune` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `commune` VARCHAR(255) NOT NULL,
  `wilaya_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `Annonces_commune_wilaya_id_8b83f446_fk_Annonces_wilaya_id` (`wilaya_id` ASC) VISIBLE,
  CONSTRAINT `Annonces_commune_wilaya_id_8b83f446_fk_Annonces_wilaya_id`
    FOREIGN KEY (`wilaya_id`)
    REFERENCES `tpigl`.`annonces_wilaya` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 527
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_images` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `image` VARCHAR(100) NOT NULL,
  `id_annonce_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `Annonces_images_id_annonce_id_e16c6aa9_fk_Annonces_annonces_id` (`id_annonce_id` ASC) VISIBLE,
  CONSTRAINT `Annonces_images_id_annonce_id_e16c6aa9_fk_Annonces_annonces_id`
    FOREIGN KEY (`id_annonce_id`)
    REFERENCES `tpigl`.`annonces_annonces` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_message` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `text` LONGTEXT NOT NULL,
  `created_at` DATETIME(6) NOT NULL,
  `annonces_id` INT NULL DEFAULT NULL,
  `contact_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `Annonces_message_annonces_id_c6633d84_fk_Annonces_annonces_id` (`annonces_id` ASC) VISIBLE,
  INDEX `Annonces_message_contact_id_d7595115_fk_Annonces_contact_id` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `Annonces_message_annonces_id_c6633d84_fk_Annonces_annonces_id`
    FOREIGN KEY (`annonces_id`)
    REFERENCES `tpigl`.`annonces_annonces` (`id`),
  CONSTRAINT `Annonces_message_contact_id_d7595115_fk_Annonces_contact_id`
    FOREIGN KEY (`contact_id`)
    REFERENCES `tpigl`.`annonces_contact` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`annonces_type_annonce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`annonces_type_annonce` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`auth_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`auth_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`django_content_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`django_content_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `app_label` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label` ASC, `model` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`auth_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`auth_permission` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `content_type_id` INT NOT NULL,
  `codename` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id` ASC, `codename` ASC) VISIBLE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `tpigl`.`django_content_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 61
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`auth_group_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`auth_group_permissions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id` ASC, `permission_id` ASC) VISIBLE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`
    FOREIGN KEY (`permission_id`)
    REFERENCES `tpigl`.`auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `tpigl`.`auth_group` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`auth_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`auth_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(128) NOT NULL,
  `last_login` DATETIME(6) NULL DEFAULT NULL,
  `is_superuser` TINYINT(1) NOT NULL,
  `username` VARCHAR(150) NOT NULL,
  `first_name` VARCHAR(150) NOT NULL,
  `last_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `is_staff` TINYINT(1) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `date_joined` DATETIME(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`auth_user_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`auth_user_groups` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id` ASC, `group_id` ASC) VISIBLE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id` ASC) VISIBLE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `tpigl`.`auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tpigl`.`auth_user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`auth_user_user_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`auth_user_user_permissions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id` ASC, `permission_id` ASC) VISIBLE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`
    FOREIGN KEY (`permission_id`)
    REFERENCES `tpigl`.`auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tpigl`.`auth_user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`django_admin_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`django_admin_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `action_time` DATETIME(6) NOT NULL,
  `object_id` LONGTEXT NULL DEFAULT NULL,
  `object_repr` VARCHAR(200) NOT NULL,
  `action_flag` SMALLINT UNSIGNED NOT NULL,
  `change_message` LONGTEXT NOT NULL,
  `content_type_id` INT NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id` ASC) VISIBLE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `tpigl`.`django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tpigl`.`auth_user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`django_migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`django_migrations` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `app` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `applied` DATETIME(6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tpigl`.`django_session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpigl`.`django_session` (
  `session_key` VARCHAR(40) NOT NULL,
  `session_data` LONGTEXT NOT NULL,
  `expire_date` DATETIME(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  INDEX `django_session_expire_date_a5c62663` (`expire_date` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
