class cm::apache inherits cm {

exec { 'apt-update':                    
  command => '/usr/bin/apt-get update'  
}

package { 'apache2':
  ensure => installed,
}

service { 'apache2':
  ensure => running,
}

package { 'mysql-server-5.5':
  ensure => installed,
}

#service { 'mysql':
#  ensure => running,
#}

package { 'php5-mysql':
  ensure => installed,
}

package {'libapache2-mod-php5':
          ensure => present,
        }
}
