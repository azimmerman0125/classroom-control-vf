
define users::managed_user (
  $shell = '/bin/bash',
  $home = "/home/${title}",
  $group = "${title}",
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
    group => $group,
  }
  file { "${home}/.ssh":
    ensure => directory,
    mode => '0700',
  }
}
