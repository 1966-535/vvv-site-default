<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'otest_default' );

/** MySQL database username */
define( 'DB_USER', 'wp' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wp' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'twJ!vGV3U6G]^-I?k,uk)sRCh;ECC4au,6O[@Vqpp0VOdn5h,]B3HiysgBO ugO-' );
define( 'SECURE_AUTH_KEY',  'D|MTSi,TSqR=X zHkamJ*9{V~pyV]D2P)x#A%JAQ7eq3P{@t-MLwt}boN#f@Hk,(' );
define( 'LOGGED_IN_KEY',    'D_itZgr!}MNKN%gbYXI;w1:)A&AOIq.*z`m]BNH8E%W5SNQcTzKUHz#&tfxB%<-W' );
define( 'NONCE_KEY',        '6%]1dfSw)*`t{zt($^G82|GV`yTqy*EJ()[|`r]M:D+rgNIWp9dArYu+TKTcw`zz' );
define( 'AUTH_SALT',        '~NZ]P3$*~ZDi~5YP*M6#(y+slfn1KNqJ(-x^^_c;L72bb+v+JGdZPOGJO0eH/7)K' );
define( 'SECURE_AUTH_SALT', 'f~A<J&Po0I{2*y1M*t_f<Gj:1HA>5fpI*VQ~HoJ`j|DAi)PM2/foe=<]=E!M5}/9' );
define( 'LOGGED_IN_SALT',   '7q?zJW86Fe>pa#|L5>9ZI[ T);%souaa}CcN<_$.3f*+E$y)R<,[*~_`sT0Q$XiL' );
define( 'NONCE_SALT',       ')kOKti$[Z;EA:;8j4Xwt4q`zfy(sL?-UY$kp1NEG6K5Rtgd_) cuMm,f[$C7J {2' );

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


// Match any requests made via xip.io.
if ( isset( $_SERVER['HTTP_HOST'] ) && preg_match('/^(local.wordpress.)\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(.xip.io)\z/', $_SERVER['HTTP_HOST'] ) ) {
    define( 'WP_HOME', 'http://' . $_SERVER['HTTP_HOST'] );
    define( 'WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST'] );
}

define( 'WP_DEBUG', true );


/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) )
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
