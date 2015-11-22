$password = 'password'
$user = 'root'
$name = 'wordpress'

class cm::db {

  package { "mysql-server": ensure => installed }
  package { "mysql": ensure => installed }

  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$password status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password $password",
    require => Service["mysql"],
  }

  define mysqldb( $user, $password ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -p$password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
      require => Service["mysqld"],
    }
  }
}
