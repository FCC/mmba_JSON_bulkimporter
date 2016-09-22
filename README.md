# mmba_JSON_bulkimporter
JSON to CSV conversion tool for FCC Speed Test JSON Result files written in PHP

This tool takes a list of JSON result files from the FCC Speed Test App and converts the source JSON files into a set of comma separated values (CSV) files with rows of results appropriate for importing into a SQL database table.  

`find data/*.json | php bulk_import.php`

Each JSON value defined in the [FCC Speed Test App data dictionary](https://github.com/FCC/mobile-mba-androidapp/wiki/Data-Representation) may appear as a row level result in any of the suite of tables.


A sample database schema is available in the repository for reference.

