#
class ntp::config (
  $keys_enable       = $ntp::params::keys_enable,
  $keys_file         = $ntp::params::keys_file,
  $config            = $ntp::params::config,
  $config_template   = $ntp::params::config_template,
  $panic             = $ntp::params::panic,
  $disable_monitor   = $ntp::params::disable_monitor,
  $restrict          = $ntp::params::restrict,
  $servers           = $ntp::params::servers,
  $preferred_servers = $ntp::params::preferred_servers,
  $udlc              = $ntp::params::udlc,
  $driftfile         = $ntp::params::driftfile,
  $keys_enable       = $ntp::params::keys_enable,
  $keys_file         = $ntp::params::keys_file,
  $keys_trusted      = $ntp::params::keys_trusted,
  $keys_requestkey   = $ntp::params::keys_requestkey,
  $keys_controlkey   = $ntp::params::keys_controlkey,
){

  if $keys_enable {
    $directory = dirname($keys_file)
    file { $directory:
      ensure  => directory,
      owner   => 0,
      group   => 0,
      mode    => '0755',
      recurse => true,
    }
  }

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }
}
