class cm::wp inherits cm {
file { '/tmp/latest.tar.gz':
        ensure => present,
        source => "puppet:///modules/cm/latest.tar.gz"
    }

    # Extract the Wordpress bundle
    exec { 'extract':
        cwd => "/tmp",
        command => "tar -xvzf latest.tar.gz",
        require => File['/tmp/latest.tar.gz'],
        path => ['/bin'],
    }

    # Copy to /var/www/
    exec { 'copy':
        command => "cp -r /tmp/wordpress/* /var/www/html",
        require => Exec['extract'],
        path => ['/bin'],
    }

    # Generate the wp-config.php file using the template
    file { '/var/www/html/wp-config.php':
        ensure => present,
        require => Exec['copy'],
        content => template("cm/wp-config.php.erb")
    }
}
