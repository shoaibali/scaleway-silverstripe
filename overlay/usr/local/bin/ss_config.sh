#!/bin/bash

cat << EOF > /var/www/_ss_environment.php
<?php
/**
 * The _ss_environment configuration for SilverStripe
 *
 * The _ss_environment.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "_ss_environment.php" and fill in the values.
 *
 *
 * @link https://docs.silverstripe.org/en/3.2/getting_started/environment_management
 *
 * @package SilverStripe
 */

// These four define set the database connection details.
define('SS_DATABASE_CLASS', 'MySQLPDODatabase');

/** The name of the database for SilverStripe */
define('SS_DATABASE_NAME', 'database_name_here');

/** MySQL database username */
define('SS_DATABASE_USERNAME', 'username_here');

/** MySQL database password */
define('SS_DATABASE_PASSWORD', 'password_here');

/** MySQL hostname */
define('SS_DATABASE_SERVER', 'localhost');

/** Environment type */
define('SS_ENVIRONMENT_TYPE', 'live');

// This causes errors to be written to the BASE_PATH/silverstripe.log file.
// Path must be relative to BASE_PATH
define('SS_ERROR_LOG', 'silverstripe.log');

global $_FILE_TO_URL_MAPPING;
$_FILE_TO_URL_MAPPING['/var/www'] = 'http://localhost';
EOF

chmod 644 /var/www/_ss_environment.php
chown www-data:www-data /var/www/_ss_environment.php
