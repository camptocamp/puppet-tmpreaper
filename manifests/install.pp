class tmpreaper::install {

  $_ensure = $::tmpreaper::enabled? {
    true    => 'present',
    default => 'absent',
  }

  package {'tmpreaper':
    ensure => $_ensure,
    name   => $::tmpreaper::package,
  }
}
