File {

define users::managed_user (
  $user = $title,
  $shell = '/bin/bash',
  $home = "/home/${user}",
  ) {
  user { $user:
    ensure => present,
    shell => $shell,
    home => $home,
  }
file { "${home}/.ssh":
  ensure => directory
}
