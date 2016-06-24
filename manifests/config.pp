# Internal class only, please check init.pp
class tmpreaper::config {
  # need string, not boolean, for augeas
  # lint:ignore:quoted_booleans
  $warn = $::tmpreaper::enabled? {
    true    => 'true',
    default => 'false',
  }
  # lint:endignore

  if $::os['family'] == 'Debian' {
    shellvar {'SHOWWARNING':
      ensure => present,
      target => '/etc/tmpreaper.conf',
      value  => $warn,
    }
  }
}
