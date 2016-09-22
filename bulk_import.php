<?php 
    require("functions.php");
    $fh = fopen("php://stdin", "r");
    if($fh === false){
        die("cannot open stdin\n");
    } 
    $newlines = array("\r","\n");
    $configuration = getConfiguration();
    while(($line = fgets($fh)) !== false){
        $f = str_replace($newlines,'', $line);
        echo "Processing $f\n";
        if( !file_exists($f) ) continue;
        $content = file_get_contents($f);
        $json = json_decode($content, TRUE);
        if( $json === FALSE ) {
            echo "Error in decoding $f \n";
            continue;
        }
        if (is_array($json) && isset($json[0])) {
            $json = $json[0];
        }
        $bname = basename($f);
        $submission_id = str_replace(".json", "", substr($bname, strrpos($bname, "_") + 1 ));
        processSubmission($configuration, $json, $submission_id);
        accessLog($json, $submission_id);
    }

