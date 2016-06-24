class tmpreaper::params {
  $enabled = true
  
  case $::os['family'] {
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
