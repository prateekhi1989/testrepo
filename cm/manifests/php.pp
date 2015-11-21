class cm::php inherits cm {
package { 'php5':
  ensure => installed,
}
file { '/var/www/html/info.php':
  ensure => file,
  content => '<?php  phpinfo(); ?>',    
  require => Package['apache2'],        
}
} 
