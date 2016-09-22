<?php

//base path, all the file paths depend on this value
//#DEFINE("BASE_PATH","/Users/yositune/data/mmba");
DEFINE("BASE_PATH","/mmba");
// location of the output files
DEFINE('DATA_DIR', 'logs/data'); 
// logs directory 
DEFINE('LOG_DIR', 'logs'); 
//directory storing received json files
DEFINE('JSON_DIR', 'data');
//directory for saving all recieved json files
DEFINE('UNASSIGNED', 'unassinged');
//prefix of the field name in the json file 
DEFINE("ENTRY_NAME_PREFIX","$"); 
//delimiter used in the config file to specify what funtion to apply to a field
DEFINE("FUNCTION_DELIMITER",":"); 
//delimiter telling a field comes from the context not to the entry itself
DEFINE("CONTEXT_NAME_PREFIX","#");
//date time format for import in the database
DEFINE("DATETIME_FORMAT","Y-m-d H:i:s"); 
// missing value for output
DEFINE("OUTPUTNULL","\N"); 
// field delimiter for the putput file
DEFINE("OUTPUTFIELDDELIMITER","\t"); 
// record delimiter for the output file
DEFINE("OUTPUTRECORDDELIMITER","\n");
// time accuracy for the output file name, expressed in seconds. Set to be 5 minutes
DEFINE('OUTFILE_NAME_TIME','300'); 
// delimiter for the different part fo file names
DEFINE('OUTFILE_NAME_DELIMITER', '.'); 
// value to be used as enterprise_id when a value is missing or cannot be used
DEFINE('NO_ENTERPRISE_ID','no_enterprise_id'); 
// enterprise_id field name in the json file
DEFINE('ENTERPRISE_ID','enterprise_id'); 
// value to be used if no sim operator code is reported
DEFINE('NO_SIM', 'no_sim');
// file name for configuration file
DEFINE('CONFIG_FILE','config.json'); 
//date time format for file name
DEFINE('DATE_FORMAT_FILE','YmdHis');
//date format for directory
DEFINE('DATE_FORMAT_DIRECTORY','Ymd');
//type index in the json blob
DEFINE('JSON_TYPE', 'type');
//timestamp index in the json blob
DEFINE('JSON_TIMESTAMP', 'timestamp');
//json section containing the tests
DEFINE('JSON_TESTS_SECTION','tests');
//context submission string
DEFINE('CONTEXT_SUBMISSION_STRING','submission_string');
//context index 
DEFINE('CONTEXT_INDEX','index');
//context enty for tests times
DEFINE('CONTEXT_TEST_TIMES','test_times');
// context entry for the enterprise_id
DEFINE('CONTEXT_ENTERPRISE_ID','enterprise_id');
// context entry for the source ip
DEFINE('CONTEXT_TZOFFSET','tzoffset');
// context entry for the IMEI
DEFINE('CONTEXT_IMEI','imei');
// context entry for the IMSI
DEFINE('CONTEXT_IMSI','imsi');
// context entry for the app_id
DEFINE('CONTEXT_APPID','app_id');
// prefix for the entry to be found in the context
DEFINE('CONTEXT_NAME_DELIMITER','#');
// json entry for the sim operator code
DEFINE('SIM_OPERATOR_CODE','sim_operator_code');
// log empty field 
DEFINE('LOG_EMPTY_FIELD','-');

//tries to extract a value from an array, if not present returns  default
function get(&$assoc, $key, $default){
    return isset($assoc[$key]) ? $assoc[$key] : $default;
}

// retrieves the configuration files and parse the content assuming it is in json format
function getConfiguration(){
    $config_file_path = BASE_PATH."/".CONFIG_FILE;
    $content = file_get_contents($config_file_path);
    if( $content === FALSE ){
        errorLog("Impossible to retrieve configuration from file: $config_file_path");
        die;
    }
    $json = json_decode($content, TRUE);
    if( $json === null ){
        errorLog("Impossible to decode configuration file $config_file_path");
        die;
    }
    return $json;
}

//return the enterprised id in the json file
function getEnterpriseId($json){
    $enterprise_id = get($json, ENTERPRISE_ID, NO_ENTERPRISE_ID);
    if(strlen($enterprise_id) == 0 || strlen($enterprise_id) > 255 ){
       return NO_ENTERPRISE_ID;
    }
    // we are going to generate directories name with the enterprise id
    // so we strip potentially dangerous characters 
    if(strpos($enterprise_id, ".") === 0){
       return NO_ENTERPRISE_ID;
    }
    if(strpos($enterprise_id, "/") !== FALSE){
       return  NO_ENTERPRISE_ID;
    }
    return $enterprise_id;
}
   
//return the submission id, the unique identifier used to retrieve an single test batch submission
function getSubmissionId($submission_content, $hostname, $ipaddress){
    return md5($hostname.$submission_content.$ipaddress);
}

// sql import file suffix generated using the enterprise_id and the timestamp at the time of
// of receptions.
function filesSuffix($enterprise_id, $timestamp){
    $time = $timestamp - ($timestamp % OUTFILE_NAME_TIME);
    return OUTFILE_NAME_DELIMITER.$enterprise_id.OUTFILE_NAME_DELIMITER.$time;
}

//output file name for a given description
//and creates the proper directory if it does not exist yet
function getDataFileName($description, $fileSuffix){
    $dirname = BASE_PATH."/".DATA_DIR ;
    if( !file_exists($dirname) ) {
        mkdir($dirname, 0777, true);
    }
    return BASE_PATH."/".DATA_DIR."/".$description['outfile'].$fileSuffix;
}

//replace special character from field 
function stripField($field){
    return str_replace(array(OUTPUTFIELDDELIMITER, OUTPUTRECORDDELIMITER), array("    ", " "), $field);
}

// parse an string array in the json file and produce a record per item in the array
function parseArray($submission_id, $entry){
    $entry_size = count($entry);
    $output = new SplFixedArray($entry_size);
    for($i = 0 ; $i < $entry_size; $i++){
        $output[$i] = $submission_id.OUTPUTFIELDDELIMITER.stripField($entry[$i]);
    }
    return implode(OUTPUTRECORDDELIMITER, $output->toArray());
} 

// parse a json object according to the description provided
function parseObject($entry, $context, $description){
    $desc_size = count($description);
    $output = array();
    foreach($description as $d ){
        $output[] = parseValue($d, $context, $entry);  
    }
    return implode(OUTPUTFIELDDELIMITER,$output).OUTPUTRECORDDELIMITER;
}

//given a description a context and an entry returns the output value
function parseValue($description, $context, $entry){
    $ret = $description;
    if(strpos($description, ENTRY_NAME_PREFIX) === 0 ){
        $description = substr( $description, 1 );
        $e = explode(FUNCTION_DELIMITER, $description);
        if( !isset($entry[$e[0]] ) ){
            $ret = OUTPUTNULL;
        }elseif( count($e) === 1){
            $ret = stripField($entry[$e[0]]);
        }else{
            //output field is function of the input $entry field
            $ret = stripField(call_user_func($e[1], $entry[$e[0]]));
        }
    //output field comes from  $context
    }elseif(strpos($description, CONTEXT_NAME_DELIMITER) === 0) {   
        $description = substr( $description , 1 );
        $e = explode(FUNCTION_DELIMITER, $description);
        if( !isset($context[$e[0]]) ){
            $ret = OUTPUTNULL;
        }elseif( count($e) === 1 ){
            $ret = $context[$e[0]];
        }else{
            $ret = context($context, $e[0], $entry[$e[1]]); 
        }
    }
    return $ret;
}

//compute the correct value from the context
function context($context, $type, $entry){
    if($type === CONTEXT_TEST_TIMES ){
        return isset($context[$type][$entry]) ? $context[$type][$entry] : OUTPUTNULL;
    }
    if($type === CONTEXT_TZOFFSET){
        return gmdate(DATETIME_FORMAT, $context[$type] + $entry);
    }
}

//convert a unix timestamp to a format suitable for importing into the db
function ts2utc($timestamp){
    return gmdate(DATETIME_FORMAT, $timestamp);
}

//processes the metric section of the json blob in order to 
//return an assciative array with timestamp => metric type
//used to match the passive metrics 
function getTestsTimesAndTypes($configuration,$json){
    $ret = array();
    if( ! isset($json[JSON_TESTS_SECTION]) ){
        return $ret;
    }
    $tests = $json[JSON_TESTS_SECTION];
    $tests_len = count($tests);
    for( $i = 0; $i < $tests_len; $i++ ){
        $e = $tests[$i];
        if(!isset($e[JSON_TYPE])) continue;
        if(!isset($e[JSON_TIMESTAMP])) continue;
        //retrive the metric name from the configuration if available 
        //otherwise use the type field from the json file
        $ret[$e[JSON_TIMESTAMP]] = isset($configuration['objects'][$e[JSON_TYPE]]['metric']) ? $configuration['objects'][$e[JSON_TYPE]]['metric']: $e[JSON_TYPE];
    }
    return $ret;
}

//process an entry in the json file, and appends the parsed output to the appropriate file
function processEntry($configuration, $context, $entry, $fileSuffix, $conf_type = NULL){
    $type =  is_null($conf_type) ? $entry[JSON_TYPE] : $conf_type;
    if(!isset($configuration['objects'][$type]) || $configuration['objects'][$type]['active'] != 'true'){
        return;
    }
    $filename = getDataFileName($configuration['objects'][$type], $fileSuffix);
    $content = parseObject($entry, $context, $configuration['objects'][$type]['outformat']);
    if(appendToFile($filename, $content) === FALSE){
       errorLog("problem in appending content to $filename"); 
    }
}

//process an array in the json file, and appends the parsed to the appropriate file
function processArray($configuration, $context, $type, $entry, $fileSuffix){
    if($configuration['array'][$type]['active'] != 'true'){
        return;
    }
    $filename = getDataFileName($configuration['array'][$type], $fileSuffix);
    $content = parseArray($context[CONTEXT_SUBMISSION_STRING], $entry)."\n";
    if(appendToFile($filename, $content) === FALSE){
       errorLog("problem in appending content to $filename"); 
    }
}


//append a line to a file for export, it takes care of concurrent operation by
// using flock function in order to garantee the atomicity of the operation
function appendToFile($filename, $content){
    $fh = fopen($filename, 'a');
    if( $fh === FALSE ){
        return FALSE;
    }
    $fl = flock($fh, LOCK_EX);
    if( $fl === FALSE ){
        fclose($fh);
        return FALSE;
    }
    fwrite($fh, $content);
    fflush($fh);
    flock($fh, LOCK_UN);
    fclose($fh);
    chmod($filename, 0777);
    return TRUE;
}

//converts the timezone field to utc offset second
function hour2seconds($tz){
    if(gettype($tz) === "string" ){
        $tz = floatval($tz);
    }
    return intval($tz * 3600); 
}

// embellish the json object with receiver info based on the configuration
function addReceiverInfo(&$json, $configuration, $receiverInfo){
    $enterprise_id = get($json,'enterprise_id', $configuration['enterprise_id']['default']['id']);
    $conf = get($configuration['enterprise_id'], $enterprise_id, $configuration['enterprise_id']['default']);
    foreach($conf['server_info'] as $info){
        if(isset($receiverInfo[$info])){
            $json[$info] = $receiverInfo[$info];
        }
    }
}

//append the passed message to the error log file
function errorLog($error_msg){
    $message = "[". date("Y/m/d H:i:s"). "] [error] ".$error_msg."\n";
    $dirname= BASE_PATH."/".LOG_DIR;
    if( !file_exists($dirname)){
        mkdir($dirname, 0777, TRUE);
    }
    appendToFile($dirname."/error.log", $message);
}


//append the array info passed to the access log file
// log
function accessLog($json, $submission_id){
    $sourceip = isset($json['_sourceip']) ? $json['_sourceip'] : LOG_EMPTY_FIELD;
    $enterprise_id = isset($json[ENTERPRISE_ID]) ? $json[ENTERPRISE_ID] : LOG_EMPTY_FIELD;
    $message = "[". gmdate("Y/m/d H:i:s")."] ".$sourceip." ".$enterprise_id." ".$submission_id."\n";
    $dirname= BASE_PATH."/".LOG_DIR;
    if( !file_exists($dirname)){
        mkdir($dirname, 0777, TRUE);
    }
    appendToFile($dirname."/access.log", $message);
}

//sanitise the sim operator code since it is used to modify the filesystem
//SIM operator code is the MCC/MNC tuple
//base on the ITU-T e.213 both must have length between 2 and 3 digits
function getSIMOperatorCode($json){
    if(!isset($json[SIM_OPERATOR_CODE])){
        return NO_SIM; 
    }
    $sim_operator_code = $json[SIM_OPERATOR_CODE];
    if(strlen($sim_operator_code) < 4 || strlen($sim_operator_code) > 6){
        return NO_SIM;
    } 
    if(!is_numeric($sim_operator_code)){
        return NO_SIM;
    }
    return $sim_operator_code;
}


//save received file and create symbolic link according to enterprise id and sim_operator_code
function saveJsonFile($submission_id, $json){
    $sim_operator_code = getSIMOperatorCode($json);
    $datetime = date(DATE_FORMAT_FILE, $json['_received']);
    $directory = date(DATE_FORMAT_DIRECTORY, $json['_received']);
    $enterprise_id = getEnterpriseId($json);
    //build file name YYYYMMDD_sourceip_submissionid.json
    $filename = $datetime;
    if(isset($json['_sourceip'])){
        $filename .= '_'.$json['_sourceip'];
    }
    $filename .= "_".$submission_id.".json";
    $unassigned_dir = BASE_PATH."/".JSON_DIR."/".UNASSIGNED."/".$directory;
    //create dir and save file
    if(!file_exists($unassigned_dir)){
        mkdir($unassigned_dir, 0777, TRUE);
    }
    $output_path = $unassigned_dir."/".$filename;
    file_put_contents($output_path, json_encode($json));
    //create dir and sym link for the enterprise_id and the sim operator code
    $assigned_dir = BASE_PATH."/".JSON_DIR."/".$enterprise_id."/".$sim_operator_code."/".$directory;
    if(!file_exists($assigned_dir)){
        mkdir($assigned_dir, 0777, TRUE);
    }
    symlink($output_path, $assigned_dir."/".$filename);
}

//process file and generate the mysql file for data import
function processSubmission($configuration, $json, $submission_id){
    $enterprise_id = getEnterpriseId($json);
    $fileSuffix = filesSuffix($enterprise_id, $json['_received']);
    //populate context to be passed to the parse functions 
    $context = array();
    $context[CONTEXT_SUBMISSION_STRING] = $submission_id;
    $context[CONTEXT_TEST_TIMES] = getTestsTimesAndTypes($configuration, $json);
    $context[CONTEXT_ENTERPRISE_ID] = getEnterpriseId($json);
    $context[CONTEXT_TZOFFSET] = hour2seconds(get($json, 'timezone', 0));

    //main section of the file
    //used to merge the object generating the submission table
    $mainSection = array();
    foreach($configuration['sections'] as $s => $t){  
        if(!isset($json[$s])) continue;
        if($t == "array" ){
                processArray($configuration, $context, $s, $json[$s], $fileSuffix);
        }elseif($t == "objects"){
            $entry_len = count($json[$s]);
            for( $i = 0; $i < $entry_len; $i++ ){
                $e = $json[$s][$i];
                //if no type is specified the entry cannot be parsed
                if(!isset($e['type'])) continue;
                if($e['type'] === 'phone_identity'){
                    $mainSection = array_merge($e, $json);    
                }else{
                    $context[CONTEXT_INDEX]= $i;
                    processEntry($configuration, $context, $e, $fileSuffix);
                }
            }
        }
    }
    processEntry($configuration, $context, $mainSection, $fileSuffix, 'submission');
}



//returns the file name to be used when saving the json file
function getJsonFileName($submission_id, $json){
    $ret = date("YmdHis", $json['_received']);
    $ret .= isset($json['_sourceip']) ? "_".$json['_sourceip']."_" : "_" ;
    $ret .= $submission_id.".json";
    return $ret;  
}


//function to convert boolean values and boolean strings to integers
function filter_boolean($value){
    $ret = 0;
    $type = gettype($value);
    if( $type === "integer" ){
        $ret = $value;
    }elseif( $type === "boolean" ){
        $ret = $value ? 1 : 0;
    }elseif( $type === "string" ){
        $ret = strcasecmp($value,"true") == 0 ? 1 : 0;
    }
    return $ret;
}
