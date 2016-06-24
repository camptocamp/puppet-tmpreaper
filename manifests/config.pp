class tmpreaper::config {
  # need string, not boolean, for augeas
  $warn = $::tmpreaper::enabled? {
    true    => 'true',
    default => 'false',
  }

  if $::os['family'] == 'Debian' {
    shellvar {'SHOWWARNING':
      ensure => present,
      target => '/etc/tmpreaper.conf',
      value  => $warn,
    }
  }
}
