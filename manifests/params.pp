class ntp::params {

  $autoupdate        = hiera('ntp_autoupdate')
  $config_template   = hiera('ntp_config_template')
  $disable_monitor   = hiera('ntp_disable_monitor')
  $keys_enable       = hiera('ntp_keys_enable')
  $keys_controlkey   = ''
  $keys_requestkey   = ''
  $keys_trusted      = []
  $package_ensure    = hiera('ntp_package_ensure')
  $preferred_servers = []
  $service_enable    = true
  $service_ensure    = hiera('ntp_service_ensure')
  $service_manage    = true
  $udlc              = false

  # On virtual machines allow large clock skews.
  $panic = str2bool($::is_virtual) ? {
    true    => false,
    default => true,
  }

  case $::osfamily {
    'AIX','Debian','RedHat','SuSE','FreeBSD','Archlinux','Gentoo' : {
      $conf = hiera("ntp_${::osfamily}_conf")
      $config       = $conf['config']
      $keys_file     = $conf['keysfile']
      $driftfile    = $conf['driftfile']
      $package_name = $conf['package_name']
      $restrict     = $conf['restrict']
      $service_name = $conf['service_name']
      $servers      = $conf['servers']
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
