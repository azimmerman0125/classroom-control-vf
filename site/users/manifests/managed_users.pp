
define users::managed_user (
  $user,
  $shell = '/bin/bash',
  $home = "/home/${user}",
  $group = $user,
  ) {
  $user = $title
  File  {
    owner => $user,
    group => $group,
  }
  user { $user:
    ensure => present,
    shell => $shell,
    home => $home,
    group => $user,
  }
  file { "${home}/.ssh":
    ensure => directory,
    mode => '0750',
  }
}
