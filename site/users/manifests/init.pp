#Defined users class
class users {
  user { 'fundamentals':
    ensure => present,
    shell  => '/sbin/nologin',
  }
}
