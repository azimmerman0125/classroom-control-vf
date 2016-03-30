define users::managed_user ( 
  $home = "/home/${title},
  $group = $title,
){
  user { $title:
    ensure => present, }
  file { "/home/${title}": 
    ensure => directory, 
    owner => $title, 
    group => $group,
  } 
}
