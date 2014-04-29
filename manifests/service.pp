#
class ntp::service(
  $service_ensure = $ntp::params::service_ensure,
  $service_manage = $ntp::params::service_manage,
  $service_name   = $ntp::params::service_name
){

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'ntp':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
