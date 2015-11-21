class cm::mysqlserver {
       
        # Create the database
        databases => {
            "${cm::wpconf::db_name}" => {
                ensure => 'present',
                charset => 'utf8'
            }
        },

        # Create the user
        users => {
            "${cm::wpconf::db_user_host}" => {
                ensure => present,
                password_hash => mysql_password("${cm::wpconf::db_user_password}")
            }
        },

        # Grant privileges to the user
        grants => {
            "${cm::wpconf::db_user_host_db}" => {
                ensure     => 'present',
                options    => ['GRANT'],
                privileges => ['ALL'],
                table      => "${cm::wpconf::db_name}.*",
                user       => "${cm::wpconf::db_user_host}",
            }
        },
    }

    # Install MySQL client and all bindings
 #   class { '::mysql::client':
  #      require => Class['::mysql::server'],
   #     bindings_enable => true
    #}


