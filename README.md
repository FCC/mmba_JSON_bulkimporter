# mmba_JSON_bulkimporter
JSON to CSV conversion tool for FCC Speed Test JSON Result files written in PHP

This tool takes a list of JSON result files from the FCC Speed Test App and converts the source JSON files into a set of comma separated values (CSV) files with rows of results appropriate for importing into a SQL database table.  

`find data/*.json | php bulk_import.php`

Each JSON value defined in the [FCC Speed Test App data dictionary](https://github.com/FCC/mobile-mba-androidapp/wiki/Data-Representation) may appear as a row level result in any of the suite of tables.  A [sample database schema](https://github.com/FCC/mmba_JSON_bulkimporter/blob/master/mobile_mba_schema.sql) is available in the repository for reference.

The `functions.php` script contains definitions for the location of the local files, source JSON data, and exported CSV files.  Edit the file and replace the "BASE_PATH" with the location of your repository's local files.  Copy source JSON files ot the /data directory or define the location of your source files on your local file system.  Browse to the /logs/data directory in your local filesystem for the converted CSV files, or define the variable for the location to store your converted files.

//base path, all the file paths depend on this value

`DEFINE("BASE_PATH","/mmba");`

// location of the output files

`DEFINE('DATA_DIR', 'logs/data');` 

//directory storing received json files

`DEFINE('JSON_DIR', 'data');`
