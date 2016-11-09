# Internal class only, please check init.pp
class tmpreaper::params {
  $enabled = true

  case $::osfamily {
    'Debian': {
      $package = 'tmpreaper'
      $cmd = 'tmpreaper'
      $verbose_option = '--showdeleted'
      $exclude_option = '--protect'
    }

    'RedHat': {
      $package = 'tmpwatch'
      $cmd = 'tmpwatch'
      $verbose_option = '-v'
      $exclude_option = '--exclude-pattern'
    }

    default: {
      fail "Unsupported osfamily '${::os['family']}'"
    }
  }
}
