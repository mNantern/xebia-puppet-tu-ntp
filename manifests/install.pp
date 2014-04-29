#
class ntp::install(
  $package_ensure = $ntp::params::package_ensure,
  $package_name           = $ntp::params::package_name
){

  package { 'ntp':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
