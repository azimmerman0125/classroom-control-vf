#Define class nginx
class nginx (
  $root = undef,
  $nginx_package_name = $nginx::params::nginx_package_name,
  $nginx_owner = $nginx::params::nginx_owner,
  $nginx_group = $nginx::params::nginx_group,
  $nginx_document_root = $nginx::params:nginx_document_root,
  $nginx_home_dir = $nginx::params::nginx_home_dir,
  $nginx_config_dir = $nginx::params::nginx_config_dir,
  $nginx_pid_dir = $nginx::params::nginx_pid_dir,
  $nginx_log_dir = $nginx::params::nginx_log_dir,
  $nginx_service_runasuser = $nginx::params::nginx_service_runasuser,
) inherits nginx::params {

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

   file {"${nginx_document_root}":
    ensure => directory,
   }

  file { "${nginx_document_root}/index.html":
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
