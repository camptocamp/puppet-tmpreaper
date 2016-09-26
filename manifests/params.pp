# Internal class only, please check init.pp
class tmpreaper::params {
  $enabled = true

  case $::osfamily {
    'Debian': {
      $package = 'tmpreaper'
      $cmd = 'tmpreaper'
      $verbose_option = '--showdeleted'
    }

    'RedHat': {
      $package = 'tmpwatch'
      $cmd = 'tmpwatch'
      $verbose_option = '-v'
    }

    default: {
      fail "Unsupported osfamily '${::os['family']}'"
    }
  }
}
