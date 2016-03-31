class nginx::params {
  case $::osfamily {
    'debian': {
      $nginx_package_name = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_home_dir = '/etc/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_pid_dir = '/var/run'
      $nginx_log_dir = '/var/log/nginx'
      $nginx_service_runasuser = 'nginx'
    }
    'redhat': {
      $nginx_package_name = 'nginx'
      $nginx_owner = 'root'
      $nginx_group = 'root'
      $nginx_home_dir = '/etc/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_pid_dir = '/var/run'
      $nginx_log_dir = '/var/log/nginx'
      $nginx_service_runasuser = 'www-data'
    }

    'windows': {
      $nginx_package_name = 'nginx-service'
      $nginx_owner = 'Administrator'
      $nginx_group = 'Administrators'
      $nginx_home_dir = 'C:/ProgramData/nginx'
      $nginx_config_dir = $nginx_home_dir
      $nginx_pid_dir = $nginx_home_dir
      $nginx_log_dir = "${nginx_home_dir}/logs"
      $nginx_service_runasuser = 'nobody'
    }

    default: {
      fail ("Operating System ${::operatingsystem} is not supported.")
    }

  }
}
