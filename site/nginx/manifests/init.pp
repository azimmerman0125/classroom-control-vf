class nginx {
  package {'ngix':
    ensure => present,
  }
  
  file {'/etc':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  
    file {'/etc/nginx':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }  
  
  file {'/etc/nginx/nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    souce => 'puppet:///modules/ngix/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  file {'/var/www/index.html':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    souce => 'puppet:///modules/ngix/index.html',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service {'nginx': 
    ensure => running,
    enable => true,
  }
}
