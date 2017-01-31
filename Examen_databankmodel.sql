-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gene` (
  `gene_id` INT NOT NULL,
  `gene_name` CHAR NULL,
  `gene_desc` CHAR NULL,
  PRIMARY KEY (`gene_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mutation` (
  `gene_ID` INT NULL,
  `start` INT NULL,
  `end` INT NULL,
  `chromosome` INT NULL,
  `mutation_id` INT NOT NULL,
  PRIMARY KEY (`mutation_id`),
  INDEX `fk_Mutation_1_idx` (`gene_ID` ASC),
  CONSTRAINT `fk_Mutation_1`
    FOREIGN KEY (`gene_ID`)
    REFERENCES `mydb`.`Gene` (`gene_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `patient_ID` INT NOT NULL AUTO_INCREMENT,
  `patient_name` VARCHAR(45) NULL,
  `sex` ENUM('M', 'F') NULL,
  `age_diagnose` INT NULL,
  `syndrome_id` INT NULL,
  PRIMARY KEY (`patient_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Syndroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Syndroom` (
  `syndrome_id` INT NOT NULL AUTO_INCREMENT,
  `syndrome_name` VARCHAR(45) NULL,
  `syndrome_desc` CHAR NULL,
  `mutation_id` INT NULL,
  PRIMARY KEY (`syndrome_id`),
  INDEX `fk_Syndroom_1_idx` (`mutation_id` ASC),
  CONSTRAINT `fk_Syndroom_1`
    FOREIGN KEY (`mutation_id`)
    REFERENCES `mydb`.`Mutation` (`mutation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient_syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient_syndrome` (
  `id` INT NOT NULL,
  `patient_id` INT NULL,
  `syndrome_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_patient_syndrome_1_idx` (`patient_id` ASC),
  INDEX `fk_patient_syndrome_2_idx` (`syndrome_id` ASC),
  CONSTRAINT `fk_patient_syndrome_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`Patient` (`patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_syndrome_2`
    FOREIGN KEY (`syndrome_id`)
    REFERENCES `mydb`.`Syndroom` (`syndrome_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
