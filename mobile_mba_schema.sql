/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_cdmacelllocation" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "metric" varchar(32) DEFAULT NULL,
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "system_id" int(4) DEFAULT NULL,
  "network_id" int(4) DEFAULT NULL,
  "ecio" int(4) DEFAULT NULL,
  "dbm" int(4) DEFAULT NULL,
  "base_station_id" int(4) DEFAULT NULL,
  "base_station_latitude" int(8) DEFAULT NULL,
  "base_station_longitude" int(8) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_cellneighbourtower" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "metric" varchar(32) DEFAULT NULL,
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "location_area_code" int(4) DEFAULT NULL,
  "cell_tower_id" int(4) DEFAULT NULL,
  "network_type_code" varchar(10) DEFAULT NULL,
  "network_type" varchar(10) DEFAULT NULL,
  "umts_psc" int(4) DEFAULT NULL,
  "rssi" int(4) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_closesttarget" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "target" varchar(100) DEFAULT NULL,
  "ipaddress" varchar(46) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_cpuactivity" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "success" tinyint(5) DEFAULT '0',
  "max_average" int(11) DEFAULT '0',
  "read_average" int(11) DEFAULT '0',
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_datacap" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "success" tinyint(5) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_gsmcelllocation" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "metric" varchar(32) DEFAULT NULL,
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "signal_strength" smallint(4) DEFAULT NULL,
  "umts_psc" int(4) DEFAULT NULL,
  "location_area_code" int(4) DEFAULT NULL,
  "cell_tower_id" int(4) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_httpget" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "success" smallint(5) DEFAULT NULL,
  "target" varchar(100) DEFAULT NULL,
  "ipaddress" varchar(46) DEFAULT NULL,
  "transfer_time" int(11) DEFAULT NULL,
  "transfer_bytes" int(11) DEFAULT NULL,
  "bytes_sec" int(11) DEFAULT NULL,
  "warmup_time" int(11) DEFAULT NULL,
  "warmup_bytes" int(11) DEFAULT NULL,
  "number_of_threads" int(11) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_httppost" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "success" smallint(5) DEFAULT NULL,
  "target" varchar(100) DEFAULT NULL,
  "ipaddress" varchar(46) DEFAULT NULL,
  "transfer_time" int(11) DEFAULT NULL,
  "transfer_bytes" int(11) DEFAULT NULL,
  "bytes_sec" int(11) DEFAULT NULL,
  "warmup_time" int(11) DEFAULT NULL,
  "warmup_bytes" int(11) DEFAULT NULL,
  "number_of_threads" int(11) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_location" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "metric" varchar(32) DEFAULT NULL,
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "source" varchar(10) DEFAULT NULL,
  "latitude" double DEFAULT NULL,
  "longitude" double DEFAULT NULL,
  "accuracy" double DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_netactivity" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "success" tinyint(5) DEFAULT NULL,
  "maxbytesout" int(11) DEFAULT NULL,
  "maxbytesin" int(11) DEFAULT NULL,
  "bytesout" int(11) DEFAULT NULL,
  "bytesin" int(11) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_netusage" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "duration" bigint(8) DEFAULT NULL,
  "total_rx_bytes" bigint(8) DEFAULT NULL,
  "total_tx_bytes" bigint(8) DEFAULT NULL,
  "mobile_rx_bytes" bigint(8) DEFAULT NULL,
  "mobile_tx_bytes" bigint(8) DEFAULT NULL,
  "app_rx_bytes" bigint(8) DEFAULT NULL,
  "app_tx_bytes" bigint(8) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_networkdata" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "metric" varchar(32) DEFAULT NULL,
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "connected" tinyint(4) DEFAULT NULL,
  "active_network_type_code" varchar(10) DEFAULT NULL,
  "active_network_type" varchar(10) DEFAULT NULL,
  "sim_operator_code" varchar(6) DEFAULT NULL,
  "sim_operator_name" varchar(32) DEFAULT NULL,
  "roaming" tinyint(10) DEFAULT NULL,
  "phone_type_code" varchar(10) DEFAULT NULL,
  "phone_type" varchar(10) DEFAULT NULL,
  "network_type_code" varchar(10) DEFAULT NULL,
  "network_type" varchar(10) DEFAULT NULL,
  "network_operator_code" varchar(10) DEFAULT NULL,
  "network_operator_name" varchar(32) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_submission" (
  "submission_id" char(32) NOT NULL DEFAULT '',
  "enterprise_id" varchar(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "devicedtime" varchar(100) NOT NULL DEFAULT '0000-00-00 00:00:00',
  "schedule_config_version" varchar(20) DEFAULT NULL,
  "sim_operator_code" varchar(6) DEFAULT NULL,
  "submission_type" varchar(20) DEFAULT NULL,
  "timezone" double DEFAULT NULL,
  "received" datetime DEFAULT NULL,
  "source_ip" varchar(20) DEFAULT NULL,
  "app_version_code" varchar(20) NOT NULL DEFAULT '',
  "app_version_name" varchar(20) NOT NULL DEFAULT '',
  "tests" smallint(4) DEFAULT NULL,
  "metrics" smallint(4) DEFAULT NULL,
  "conditions" smallint(4) DEFAULT NULL,
  "os_type" varchar(20) DEFAULT NULL,
  "os_version" varchar(20) DEFAULT NULL,
  "model" varchar(20) DEFAULT NULL,
  "manufacturer" varchar(20) DEFAULT NULL,
  "imei" varchar(16) DEFAULT NULL,
  "imsi" varchar(15) DEFAULT NULL,
  "iosapp_id" varchar(36) DEFAULT NULL,
  "mobile_location_id" int(10) unsigned DEFAULT NULL,
  PRIMARY KEY ("submission_id"),
  KEY "ent_loc" ("enterprise_id","localdtime")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "curr_udplatency" (
  "ix" smallint(4) NOT NULL DEFAULT '0',
  "submission_id" char(32) NOT NULL DEFAULT '',
  "dtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "localdtime" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  "success" smallint(4) DEFAULT NULL,
  "target" varchar(100) DEFAULT NULL,
  "ipaddress" varchar(46) DEFAULT NULL,
  "rtt_avg" int(11) DEFAULT NULL,
  "rtt_min" int(11) DEFAULT NULL,
  "rtt_max" int(11) DEFAULT NULL,
  "rtt_stddev" int(11) DEFAULT NULL,
  "received_packets" int(11) DEFAULT NULL,
  "lost_packets" int(11) DEFAULT NULL,
  PRIMARY KEY ("submission_id","localdtime","ix")
);
/*!40101 SET character_set_client = @saved_cs_client */;
