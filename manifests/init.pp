class ntp (
  $autoupdate        = $ntp::params::autoupdate,
  $config            = $ntp::params::config,
  $config_template   = $ntp::params::config_template,
  $disable_monitor   = $ntp::params::disable_monitor,
  $driftfile         = $ntp::params::driftfile,
  $keys_enable       = $ntp::params::keys_enable,
  $keys_file         = $ntp::params::keys_file,
  $keys_controlkey   = $ntp::params::keys_controlkey,
  $keys_requestkey   = $ntp::params::keys_requestkey,
  $keys_trusted      = $ntp::params::keys_trusted,
  $package_ensure    = $ntp::params::package_ensure,
  $package_name      = $ntp::params::package_name,
  $panic             = $ntp::params::panic,
  $preferred_servers = $ntp::params::preferred_servers,
  $restrict          = $ntp::params::restrict,
  $servers           = $ntp::params::servers,
  $service_enable    = $ntp::params::service_enable,
  $service_ensure    = $ntp::params::service_ensure,
  $service_manage    = $ntp::params::service_manage,
  $service_name      = $ntp::params::service_name,
  $udlc              = $ntp::params::udlc
) inherits ntp::params {

  validate_absolute_path($config)
  validate_string($config_template)
  validate_bool($disable_monitor)
  validate_absolute_path($driftfile)
  validate_bool($keys_enable)
  validate_re($keys_controlkey, ['^\d+$', ''])
  validate_re($keys_requestkey, ['^\d+$', ''])
  validate_array($keys_trusted)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_bool($panic)
  validate_array($preferred_servers)
  validate_array($restrict)
  validate_array($servers)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_bool($udlc)

  if $autoupdate {
    notice('autoupdate parameter has been deprecated and replaced with package_ensure.  Set this to latest for the same behavior as autoupdate => true.')
  }

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': } ->
  class { 'ntp::install': 
    package_ensure => $package_ensure,
    package_name   => $package_name
  } ->
  class { 'ntp::config': 
    config            => $config,
    config_template   => $config_template,
    disable_monitor   => $disable_monitor,
    driftfile         => $driftfile,
    keys_enable       => $keys_enable,
    keys_file         => $keys_file,
    keys_controlkey   => $keys_controlkey,
    keys_requestkey   => $keys_requestkey,
    keys_trusted      => $keys_trusted,
    panic             => $panic,
    preferred_servers => $preferred_servers,
    restrict          => $restrict,
    servers           => $servers,
    udlc              => $udlc
  } ~>
  class { 'ntp::service': 
    service_ensure => $service_ensure,
    service_manage => $service_manage,
    service_name   => $service_name
  } ->
  anchor { 'ntp::end': }

}
