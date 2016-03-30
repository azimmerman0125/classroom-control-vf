class nginx {

  File {
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0664',
  }
  package {'nginx':
    ensure => present,
  }
  
  file {'/etc':
    ensure => directory,
  }
  
    file {'/etc/nginx':
    ensure => directory,
  }  
  
  file {'/etc/nginx/conf.d':
    ensure => directory,
  }  
  
  file {'/etc/nginx/nginx.conf':
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

    file {'/var':
    ensure => directory,
  }  
    file {'/var/www':
    ensure => directory,
  }    

  file {'/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  
  file {'/etc/nginx/conf.d/default.conf':
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service['nginx']
  }

  service {'nginx': 
    ensure => running,
    enable => true,
  }
}
