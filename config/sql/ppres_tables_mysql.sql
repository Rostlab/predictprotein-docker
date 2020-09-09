-- MySQL dump 10.13  Distrib 5.5.50, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ppres
-- ------------------------------------------------------
-- Server version	5.5.50-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acl`
--

DROP TABLE IF EXISTS `acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl` (
  `hash_id` int(11) NOT NULL,
  `ugo` enum('u','g','o') CHARACTER SET utf8 NOT NULL,
  `ent_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'entity id',
  `mode` tinyint(3) unsigned NOT NULL COMMENT 'mode bits, lowest 4 bits are meaningful',
  UNIQUE KEY `hash_id` (`hash_id`,`ugo`,`ent_id`),
  KEY `ugo` (`ugo`),
  KEY `ent_id` (`ent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_test`
--

DROP TABLE IF EXISTS `acl_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_test` (
  `hash_id` int(11) NOT NULL,
  `ugo` enum('u','g','o') CHARACTER SET utf8 NOT NULL,
  `ent_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'entity id',
  `mode` tinyint(3) unsigned NOT NULL COMMENT 'mode bits, lowest 4 bits are meaningful',
  UNIQUE KEY `hash_id` (`hash_id`,`ugo`,`ent_id`),
  KEY `ugo` (`ugo`),
  KEY `ent_id` (`ent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `acl_view`
--

DROP TABLE IF EXISTS `acl_view`;
/*!50001 DROP VIEW IF EXISTS `acl_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `acl_view` (
  `hash_id` tinyint NOT NULL,
  `hash` tinyint NOT NULL,
  `ugo` tinyint NOT NULL,
  `ent_id` tinyint NOT NULL,
  `mode` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `hash_id` int(11) NOT NULL DEFAULT '0',
  `met_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE latin1_bin NOT NULL,
  `mtime` datetime DEFAULT NULL COMMENT 'original result file modification time',
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `hash_id` (`hash_id`,`name`),
  KEY `m_id` (`met_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1070519098 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_test`
--

DROP TABLE IF EXISTS `file_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_test` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `hash_id` int(11) NOT NULL DEFAULT '0',
  `met_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE latin1_bin NOT NULL,
  `mtime` datetime DEFAULT NULL COMMENT 'original result file modification time',
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `hash_id` (`hash_id`,`name`),
  KEY `m_id` (`met_id`)
) ENGINE=MyISAM AUTO_INCREMENT=595531412 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_test2`
--

DROP TABLE IF EXISTS `file_test2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_test2` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `hash_id` int(11) NOT NULL DEFAULT '0',
  `met_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) COLLATE latin1_bin NOT NULL,
  `mtime` datetime DEFAULT NULL COMMENT 'original result file modification time',
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `hash_id` (`hash_id`,`name`),
  KEY `m_id` (`met_id`)
) ENGINE=MyISAM AUTO_INCREMENT=999 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `file_view`
--

DROP TABLE IF EXISTS `file_view`;
/*!50001 DROP VIEW IF EXISTS `file_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `file_view` (
  `seq_id` tinyint NOT NULL,
  `sequence` tinyint NOT NULL,
  `pset_id` tinyint NOT NULL,
  `par_string` tinyint NOT NULL,
  `hash_id` tinyint NOT NULL,
  `hash` tinyint NOT NULL,
  `timestamp` tinyint NOT NULL,
  `file_id` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `mtime` tinyint NOT NULL,
  `method` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hash`
--

DROP TABLE IF EXISTS `hash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hash` (
  `hash_id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` char(40) COLLATE latin1_bin NOT NULL COMMENT 'sha1 hash in hexadecimal encoding',
  `seq_id` int(11) NOT NULL DEFAULT '0',
  `pset_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hash_id`),
  UNIQUE KEY `seq_id` (`seq_id`,`pset_id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `timestamp` (`timestamp`),
  KEY `pset_id` (`pset_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28358830 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hash_collision`
--

DROP TABLE IF EXISTS `hash_collision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hash_collision` (
  `hash_id` int(11) NOT NULL,
  `collision_seq_id` int(11) NOT NULL,
  `collision_pset_id` int(11) NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `collision_seq_id` (`collision_seq_id`),
  KEY `collision_pset_id` (`collision_pset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hash_collision_test`
--

DROP TABLE IF EXISTS `hash_collision_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hash_collision_test` (
  `hash_id` int(11) NOT NULL,
  `collision_seq_id` int(11) NOT NULL,
  `collision_pset_id` int(11) NOT NULL,
  PRIMARY KEY (`hash_id`),
  KEY `collision_seq_id` (`collision_seq_id`),
  KEY `collision_pset_id` (`collision_pset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hash_test`
--

DROP TABLE IF EXISTS `hash_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hash_test` (
  `hash_id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` char(40) COLLATE latin1_bin NOT NULL COMMENT 'sha1 hash in hexadecimal encoding',
  `seq_id` int(11) NOT NULL DEFAULT '0',
  `pset_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hash_id`),
  UNIQUE KEY `seq_id` (`seq_id`,`pset_id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `timestamp` (`timestamp`),
  KEY `pset_id` (`pset_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20001 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `hash_view`
--

DROP TABLE IF EXISTS `hash_view`;
/*!50001 DROP VIEW IF EXISTS `hash_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `hash_view` (
  `seq_id` tinyint NOT NULL,
  `sequence` tinyint NOT NULL,
  `pset_id` tinyint NOT NULL,
  `par_string` tinyint NOT NULL,
  `hash_id` tinyint NOT NULL,
  `hash` tinyint NOT NULL,
  `timestamp` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `method`
--

DROP TABLE IF EXISTS `method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `method` (
  `met_id` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`met_id`),
  UNIQUE KEY `method` (`method`)
) ENGINE=MyISAM AUTO_INCREMENT=24145 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `param`
--

DROP TABLE IF EXISTS `param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `param` (
  `par_id` int(11) NOT NULL AUTO_INCREMENT,
  `met_id` int(11) NOT NULL,
  `param` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`par_id`),
  UNIQUE KEY `met_id` (`met_id`,`param`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `param_set`
--

DROP TABLE IF EXISTS `param_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `param_set` (
  `pset_id` int(11) NOT NULL,
  `met_id` int(11) NOT NULL,
  `par_id` int(11) NOT NULL,
  `par_value` char(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`pset_id`,`met_id`,`par_id`),
  KEY `m_id` (`met_id`),
  KEY `param_id` (`par_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `param_set_aux`
--

DROP TABLE IF EXISTS `param_set_aux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `param_set_aux` (
  `pset_id` int(11) NOT NULL AUTO_INCREMENT,
  `par_string` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`pset_id`),
  UNIQUE KEY `par_string` (`par_string`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_biological_process`
--

DROP TABLE IF EXISTS `ppc_search_biological_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_biological_process` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `go_id` int(11) NOT NULL COMMENT 'Go identifier as a integer (ie GO:015895 will be stored as 15895)',
  KEY `ind_bp_sequence` (`sequence_id`),
  KEY `ind_bp_go` (`go_id`),
  CONSTRAINT `ppc_search_biological_process_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of go terms describing biological processes of a protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_cellular_component`
--

DROP TABLE IF EXISTS `ppc_search_cellular_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_cellular_component` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `go_id` int(11) NOT NULL COMMENT 'Go identifier as a integer (ie GO:015895 will be stored as 15895)',
  KEY `ind_cc_sequence` (`sequence_id`),
  KEY `ind_cc_go` (`go_id`),
  CONSTRAINT `ppc_search_cellular_component_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of go terms describing cellular components of a protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_disorder_method`
--

DROP TABLE IF EXISTS `ppc_search_disorder_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_disorder_method` (
  `id` tinyint(4) NOT NULL,
  `name` text COMMENT 'name of the method',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='describes different method used for disorder prediction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_disorder_region`
--

DROP TABLE IF EXISTS `ppc_search_disorder_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_disorder_region` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `length` int(11) NOT NULL COMMENT 'length of the disordered region ',
  `disorder_method_id` tinyint(4) NOT NULL COMMENT 'method used for the prediction',
  `count` int(11) NOT NULL COMMENT 'how many regions with given length for given method were predicted',
  KEY `disorder_method_id` (`disorder_method_id`),
  KEY `ind_dr_length` (`length`),
  KEY `ind_dr_sequence` (`sequence_id`),
  CONSTRAINT `ppc_search_disorder_region_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`),
  CONSTRAINT `ppc_search_disorder_region_ibfk_2` FOREIGN KEY (`disorder_method_id`) REFERENCES `ppc_search_disorder_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Number of disordered regions of a protein with a given length. This table contains data only above certain threshold (current threshold = 20)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_helices`
--

DROP TABLE IF EXISTS `ppc_search_helices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_helices` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `helix` int(11) NOT NULL COMMENT 'length of a single helix',
  KEY `ind_hel_sequence` (`sequence_id`),
  KEY `ind_hel_helix` (`helix`),
  CONSTRAINT `ppc_search_helices_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains list of helix lengths for given protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_molecular_function`
--

DROP TABLE IF EXISTS `ppc_search_molecular_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_molecular_function` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `go_id` int(11) NOT NULL COMMENT 'Go identifier as a integer (ie GO:015895 will be stored as 15895)',
  KEY `ind_mf_sequence` (`sequence_id`),
  KEY `ind_mf_go` (`go_id`),
  CONSTRAINT `ppc_search_molecular_function_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of go terms describing molecular functions of a protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_non_disorder_region`
--

DROP TABLE IF EXISTS `ppc_search_non_disorder_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_non_disorder_region` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `length` int(11) NOT NULL COMMENT 'length of the longest non disordered region',
  `disorder_method_id` tinyint(4) NOT NULL COMMENT 'method used for the prediction',
  KEY `disorder_method_id` (`disorder_method_id`),
  KEY `ind_ndr_length` (`length`),
  KEY `ind_ndr_sequence` (`sequence_id`),
  CONSTRAINT `ppc_search_non_disorder_region_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`),
  CONSTRAINT `ppc_search_non_disorder_region_ibfk_2` FOREIGN KEY (`disorder_method_id`) REFERENCES `ppc_search_disorder_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Describes the longest non disordered region ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_pfam`
--

DROP TABLE IF EXISTS `ppc_search_pfam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_pfam` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `term` int(11) NOT NULL COMMENT 'Pfam identifier as a integer (ie PF15895 will be stored as 15895)',
  KEY `ind_pfam_sequence` (`sequence_id`),
  KEY `ind_pfam_term` (`term`),
  CONSTRAINT `ppc_search_pfam_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of pfam terms for a protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_prosite`
--

DROP TABLE IF EXISTS `ppc_search_prosite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_prosite` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `term` varchar(12) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  KEY `ind_pros_sequence` (`sequence_id`),
  KEY `ind_pros_term` (`term`),
  CONSTRAINT `ppc_search_prosite_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of prosite terms for protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_sequence`
--

DROP TABLE IF EXISTS `ppc_search_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(40) NOT NULL COMMENT 'hash value used to identify data on cluster',
  `helices_content` float DEFAULT NULL COMMENT 'SECONDARY STRUCTURE: helices content',
  `strand_content` float DEFAULT NULL COMMENT 'SECONDARY STRUCTURE: strand content',
  `loop_content` float DEFAULT NULL COMMENT 'SECONDARY STRUCTURE: loop content',
  `buried` float DEFAULT NULL COMMENT 'SOLVENT ACCESIBILITY: buried ratio',
  `exposed` float DEFAULT NULL COMMENT 'SOLVENT ACCESIBILITY: exposed ratio',
  `tmh_number_phd` smallint(5) unsigned DEFAULT NULL COMMENT 'TRANSMEMBRANE HELICES: number by phd method',
  `tmh_number_tmhmm` smallint(5) unsigned DEFAULT NULL COMMENT 'TRANSMEMBRANE HELICES: number by tmhmm method',
  `tmh_number_tmseg` smallint(5) unsigned DEFAULT NULL COMMENT 'TRANSMEMBRANE HELICES: number by tmseg method',
  `tmh_topology_phd_id` tinyint(4) DEFAULT NULL COMMENT 'TRANSMEMBRANE HELICES: topology by phd method',
  `tmh_topology_tmhmm_id` tinyint(4) DEFAULT NULL COMMENT 'TRANSMEMBRANE HELICES: topology by tmhmm method',
  `tmh_topology_tmseg_id` tinyint(4) DEFAULT NULL COMMENT 'TRANSMEMBRANE HELICES: topology by tmseg method',
  `low_complexity` float DEFAULT NULL COMMENT 'LOW COMPLEXITY: ratio of low complexity segments',
  `bridge_fraction` float DEFAULT NULL COMMENT 'DISUPLHATE BRIDGES: ratio of Cys not in a bridge',
  `bridge_number` smallint(5) unsigned DEFAULT NULL COMMENT 'DISUPLHATE BRIDGES: number of bridges',
  `protein_binding_residues` smallint(5) unsigned DEFAULT NULL COMMENT 'BINDING SITES: number of protein binding residues',
  `xna_binding` tinyint(1) DEFAULT NULL COMMENT 'BINDING SITES: does protein bind XNA',
  `dna_binding` tinyint(1) DEFAULT NULL COMMENT 'BINDING SITES: does protein bind DNA',
  `rna_binding` tinyint(1) DEFAULT NULL COMMENT 'BINDING SITES: does protein bind RNA',
  `family_size` int(11) DEFAULT NULL COMMENT 'ALIGNMENT: family size',
  `longest_coiled_region_14` smallint(5) unsigned DEFAULT NULL COMMENT 'COILED COILS: longest coiled region using PROB-14',
  `longest_coiled_region_21` smallint(5) unsigned DEFAULT NULL COMMENT 'COILED COILS: longest coiled region using PROB-21',
  `longest_coiled_region_28` smallint(5) unsigned DEFAULT NULL COMMENT 'COILED COILS: longest coiled region using PROB-28',
  `coiled_regions_number_14` smallint(5) unsigned DEFAULT NULL COMMENT 'COILED COILS: number of coiled regions using PROB-14',
  `coiled_regions_number_21` smallint(5) unsigned DEFAULT NULL COMMENT 'COILED COILS: number of coiled regions using PROB-21',
  `coiled_regions_number_28` smallint(5) unsigned DEFAULT NULL COMMENT 'COILED COILS: number of coiled regions using PROB-28',
  `tmb_probability` float DEFAULT NULL COMMENT 'BACTERIAL TRANSMEMBRANE BETA BARRELS: estimated percent chance that protein is a TMB (Accuracy)',
  `tmb_strands` smallint(5) unsigned DEFAULT NULL COMMENT 'BACTERIAL TRANSMEMBRANE BETA BARRELS: predicted transmembrane strands',
  `sequence` text NOT NULL COMMENT 'amino acid sequence',
  PRIMARY KEY (`id`),
  KEY `ind_seq_helices_content` (`helices_content`),
  KEY `ind_seq_strand_content` (`strand_content`),
  KEY `ind_seq_loop_content` (`loop_content`),
  KEY `ind_seq_buried` (`buried`),
  KEY `ind_seq_exposed` (`exposed`),
  KEY `ind_seq_tmh_number_phd` (`tmh_number_phd`),
  KEY `ind_seq_tmh_number_tmhmm` (`tmh_number_tmhmm`),
  KEY `ind_seq_tmh_number_tmseg` (`tmh_number_tmseg`),
  KEY `ind_seq_tmh_topology_phd_id` (`tmh_topology_phd_id`),
  KEY `ind_seq_tmh_topology_tmhmm_id` (`tmh_topology_tmhmm_id`),
  KEY `ind_seq_tmh_topology_tmseg_id` (`tmh_topology_tmseg_id`),
  KEY `ind_seq_low_complexity` (`low_complexity`),
  KEY `ind_seq_bridge_fraction` (`bridge_fraction`),
  KEY `ind_seq_bridge_number` (`bridge_number`),
  KEY `ind_seq_protein_binding_residues` (`protein_binding_residues`),
  KEY `ind_seq_xna_binding` (`xna_binding`),
  KEY `ind_seq_dna_binding` (`dna_binding`),
  KEY `ind_seq_rna_binding` (`rna_binding`),
  KEY `ind_seq_family_size` (`family_size`),
  KEY `ind_seq_longest_coiled_region_14` (`longest_coiled_region_14`),
  KEY `ind_seq_longest_coiled_region_21` (`longest_coiled_region_21`),
  KEY `ind_seq_longest_coiled_region_28` (`longest_coiled_region_28`),
  KEY `ind_seq_coiled_regions_number_14` (`coiled_regions_number_14`),
  KEY `ind_seq_coiled_regions_number_21` (`coiled_regions_number_21`),
  KEY `ind_seq_coiled_regions_number_28` (`coiled_regions_number_28`),
  KEY `ind_seq_tmb_probability` (`tmb_probability`),
  KEY `ind_seq_tmb_strands` (`tmb_strands`),
  KEY `ind_seq_sequence` (`sequence`(30)),
  KEY `ind_seq_hash` (`hash`),
  CONSTRAINT `ppc_search_sequence_ibfk_1` FOREIGN KEY (`tmh_topology_phd_id`) REFERENCES `ppc_search_tmh_topology` (`id`),
  CONSTRAINT `ppc_search_sequence_ibfk_2` FOREIGN KEY (`tmh_topology_tmhmm_id`) REFERENCES `ppc_search_tmh_topology` (`id`),
  CONSTRAINT `ppc_search_sequence_ibfk_3` FOREIGN KEY (`tmh_topology_tmseg_id`) REFERENCES `ppc_search_tmh_topology` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14666798 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_strands`
--

DROP TABLE IF EXISTS `ppc_search_strands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_strands` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `strand` int(11) NOT NULL COMMENT 'length of a single strand',
  KEY `ind_str_sequence` (`sequence_id`),
  KEY `ind_str_helix` (`strand`),
  CONSTRAINT `ppc_search_strands_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains list of strand lengths for given protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_subcellular_localization`
--

DROP TABLE IF EXISTS `ppc_search_subcellular_localization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_subcellular_localization` (
  `sequence_id` int(11) NOT NULL COMMENT 'Unique database id of protein in sequence table',
  `go_id` int(11) NOT NULL COMMENT 'Go identifier as a integer (ie GO:015895 will be stored as 15895)',
  `source` varchar(30) NOT NULL COMMENT 'Source of the prediction',
  `initial_prediction` varchar(30) NOT NULL COMMENT '???',
  `quality` float NOT NULL COMMENT 'Quality of the prediction',
  KEY `ind_sl_sequence` (`sequence_id`),
  KEY `ind_sl_go` (`go_id`),
  KEY `ind_sl_initial_prediction` (`initial_prediction`),
  KEY `ind_sl_quality` (`quality`),
  CONSTRAINT `ppc_search_subcellular_localization_ibfk_1` FOREIGN KEY (`sequence_id`) REFERENCES `ppc_search_sequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of go terms describing subcellular localizations of a protein';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ppc_search_tmh_topology`
--

DROP TABLE IF EXISTS `ppc_search_tmh_topology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppc_search_tmh_topology` (
  `id` tinyint(4) NOT NULL,
  `name` text COMMENT 'name of the type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='describes different types of transmembrane helices topology';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qc`
--

DROP TABLE IF EXISTS `qc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qc` (
  `hash_id` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('ok','vanished','extrafiles') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `seq_id` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` longtext NOT NULL,
  PRIMARY KEY (`seq_id`),
  KEY `sequence` (`sequence`(1000))
) ENGINE=MyISAM AUTO_INCREMENT=15409797 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence_test`
--

DROP TABLE IF EXISTS `sequence_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence_test` (
  `seq_id` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` longtext NOT NULL,
  PRIMARY KEY (`seq_id`),
  KEY `sequence` (`sequence`(1000))
) ENGINE=MyISAM AUTO_INCREMENT=20001 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `sequence_view`
--

DROP TABLE IF EXISTS `sequence_view`;
/*!50001 DROP VIEW IF EXISTS `sequence_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `sequence_view` (
  `seq_id` tinyint NOT NULL,
  `sequence` tinyint NOT NULL,
  `hash_id` tinyint NOT NULL,
  `hash` tinyint NOT NULL,
  `pset_id` tinyint NOT NULL,
  `timestamp` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'ppres'
--
/*!50003 DROP PROCEDURE IF EXISTS `insert_hash` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_hash`( in __hash char(40), in __seq_id int, in __pset_id int, out __hash_id int, out __found_seq_id int, out __found_pset_id int )
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
begin
set __hash_id = 0;
select hash_id, seq_id, pset_id into __hash_id, __found_seq_id, __found_pset_id from hash where hash = __hash;
if __hash_id = 0 then insert into hash ( `hash`, `seq_id`, `pset_id` ) values ( __hash, __seq_id, __pset_id );
select last_insert_id(), __seq_id, __pset_id into __hash_id, __found_seq_id, __found_pset_id;
else update hash set timestamp = NULL where hash_id = __hash_id; 
end if; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_param_set_aux` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_param_set_aux`( in __par_string varchar(255), out __pset_id int )
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
begin
set __pset_id = 0;
select pset_id into __pset_id from param_set_aux where par_string = __par_string;
if __pset_id = 0 then insert into param_set_aux values (NULL, __par_string );
select last_insert_id() into __pset_id;
end if; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_seq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_seq`( in __seq longtext, out __seq_id int )
    MODIFIES SQL DATA
    SQL SECURITY INVOKER
begin
set __seq_id = 0;
select seq_id into __seq_id from sequence where sequence = __seq;
if __seq_id = 0 then insert into sequence values (NULL, __seq );
select last_insert_id() into __seq_id;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `acl_view`
--

/*!50001 DROP TABLE IF EXISTS `acl_view`*/;
/*!50001 DROP VIEW IF EXISTS `acl_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.200.0.%` SQL SECURITY INVOKER */
/*!50001 VIEW `acl_view` AS select `hash`.`hash_id` AS `hash_id`,`hash`.`hash` AS `hash`,`acl`.`ugo` AS `ugo`,`acl`.`ent_id` AS `ent_id`,`acl`.`mode` AS `mode` from (`hash` join `acl` on((`hash`.`hash_id` = `acl`.`hash_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `file_view`
--

/*!50001 DROP TABLE IF EXISTS `file_view`*/;
/*!50001 DROP VIEW IF EXISTS `file_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`lkajan`@`%` SQL SECURITY INVOKER */
/*!50001 VIEW `file_view` AS select `hash`.`seq_id` AS `seq_id`,`sequence`.`sequence` AS `sequence`,`hash`.`pset_id` AS `pset_id`,`param_set_aux`.`par_string` AS `par_string`,`file`.`hash_id` AS `hash_id`,`hash`.`hash` AS `hash`,`hash`.`timestamp` AS `timestamp`,`file`.`file_id` AS `file_id`,`file`.`name` AS `filename`,`file`.`mtime` AS `mtime`,`method`.`method` AS `method` from ((((`file` join `hash` on((`file`.`hash_id` = `hash`.`hash_id`))) join `param_set_aux` on((`hash`.`pset_id` = `param_set_aux`.`pset_id`))) join `sequence` on((`hash`.`seq_id` = `sequence`.`seq_id`))) join `method` on((`file`.`met_id` = `method`.`met_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `hash_view`
--

/*!50001 DROP TABLE IF EXISTS `hash_view`*/;
/*!50001 DROP VIEW IF EXISTS `hash_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`lkajan`@`%` SQL SECURITY INVOKER */
/*!50001 VIEW `hash_view` AS select `sequence`.`seq_id` AS `seq_id`,`sequence`.`sequence` AS `sequence`,`param_set_aux`.`pset_id` AS `pset_id`,`param_set_aux`.`par_string` AS `par_string`,`hash`.`hash_id` AS `hash_id`,`hash`.`hash` AS `hash`,`hash`.`timestamp` AS `timestamp` from ((`hash` join `sequence` on((`hash`.`seq_id` = `sequence`.`seq_id`))) join `param_set_aux` on((`hash`.`pset_id` = `param_set_aux`.`pset_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sequence_view`
--

/*!50001 DROP TABLE IF EXISTS `sequence_view`*/;
/*!50001 DROP VIEW IF EXISTS `sequence_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.200.0.%` SQL SECURITY INVOKER */
/*!50001 VIEW `sequence_view` AS select `sequence`.`seq_id` AS `seq_id`,`sequence`.`sequence` AS `sequence`,`hash`.`hash_id` AS `hash_id`,`hash`.`hash` AS `hash`,`hash`.`pset_id` AS `pset_id`,`hash`.`timestamp` AS `timestamp` from (`sequence` join `hash` on((`sequence`.`seq_id` = `hash`.`seq_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-02 15:17:10
