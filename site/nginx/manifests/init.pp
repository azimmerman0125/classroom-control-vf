#Define class nginx
class nginx {
  case $::osfamily {
    'debian': {
      $nginx_package_name = 'nginx'
      $nginx_ower = 'root'
      $nginx_group = 'root'
      $nginx_document_root = '/var/www'
      $nginx_home_dir = '/etc/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_logs_dir = '/var/log/nginx'
      $nginx_service_runasuser = 'nginx'

    }
    'redhat': {
      $nginx_package_name = 'nginx'
      $nginx_ower = 'root'
      $nginx_group = 'root'
      $nginx_document_root = '/var/www'
      $nginx_home_dir = '/etc/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_logs_dir = '/var/log/nginx'
      $nginx_service_runasuser = 'www-data'
    }

    'windows': {
      $nginx_package_name = 'nginx-service'
      $nginx_ower = 'Administrator'
      $nginx_group = 'Administrators'
      $nginx_home_dir = 'C:/ProgramData/nginx'
      $nginx_document_root = "${nginx_home_dir}/html"
      $nginx_config_dir = $nginx_home_dir
      $nginx_logs_dir = "${nginx_home_dir}/logs"
      $nginx_service_runasuser = 'nobody'

    }

    default: {
      fail ("Operating System ${::operatingsystem} is not supported.")
    }

  }

  #Setting the default values for all OSes
  $nginx_serverblock_dir = "${nginx_home_dir}/conf.d"
  $nginx_service_name = 'nginx'

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
