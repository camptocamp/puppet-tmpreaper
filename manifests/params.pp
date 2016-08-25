# Internal class only, please check init.pp
class tmpreaper::params {
  $enabled = true

  case $::osfamily {
    'Debian': {
      $package = 'tmpreaper'
      $cmd = 'tmpreaper'
    }

    'RedHat': {
      $package = 'tmpwatch'
      $cmd = 'tmpwatch'
    }

    default: {
      fail "Unsupported osfamily '${::os['family']}'"
    }
  }
}
