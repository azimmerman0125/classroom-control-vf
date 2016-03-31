#Define class nginx
class nginx (
  $root = undef,
) {
  case $::osfamily {
    'debian': {
      $nginx_package_name = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      #$nginx_document_root = '/var/www'
      $nginx_home_dir = '/etc/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_pid_dir = '/var/run'
      $nginx_log_dir = '/var/log/nginx'
      $nginx_service_runasuser = 'nginx'
      $default_root = "/var/www"
    }
    'redhat': {
      $nginx_package_name = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      #$nginx_document_root = '/var/www'
      $nginx_home_dir = '/etc/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_pid_dir = '/var/run'
      $nginx_log_dir = '/var/log/nginx'
      $nginx_service_runasuser = 'www-data'
      $default_root = "/var/www"
    }

    'windows': {
      $nginx_package_name = 'nginx-service'
      $nginx_owner = 'Administrator'
      $nginx_group = 'Administrators'
      $nginx_home_dir = 'C:/ProgramData/nginx'
      #$nginx_document_root = "${nginx_home_dir}/html"
      $nginx_config_dir = $nginx_home_dir
      $nginx_pid_dir = $nginx_home_dir
      $nginx_log_dir = "${nginx_home_dir}/logs"
      $nginx_service_runasuser = 'nobody'
      $default_root = "C:/ProgramData/nginx/html"
    }

    default: {
      fail ("Operating System ${::operatingsystem} is not supported.")
    }

  }

  #Setting the default values for all OSes
  $nginx_serverblock_dir = "${nginx_home_dir}/conf.d"
  $nginx_service_name = 'nginx'


  $nginx_document_root = $nginx_document_root ? {
    undef => $default_root,
    default => $root,
  }

  File {
    ensure => 'file',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package {'nginx':
    ensure => present,
  }
  
  file {'/etc/nginx/conf.d':
    ensure => directory,
  }
  
  file {'/etc/nginx/nginx.conf':
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

    file {'/var/www':
    ensure => directory,
  }

  file {'/var/www/index.html':
    source  => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file {'/etc/nginx/conf.d/default.conf':
    content => template('nginx/default.conf.erb'),
    notify  => Service['nginx']
  }

  service {'nginx':
    ensure => running,
    enable => true,
  }
}
