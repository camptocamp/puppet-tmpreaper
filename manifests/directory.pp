# Definition: tmpreaper::directory
#       Create or remove a cronjob for a specific directory
# Parameters:
#       directory: mandatory - absolute path to directory
#       rtag: mandatory   - process tag for syslog
#       age: optional     - set max age for files in directory
#       hour: optional    - set cron hour
#       minute: optional  - set cron minute
#       user: optional    - set cron user
#       exclude: optional - set pattern(s) to exclude
define tmpreaper::directory(
  $directory,
  $rtag,
  $ensure  = 'present',
  $age     = '1w',
  $hour    = undef,
  $minute  = undef,
  $user    = 'root',
  $exclude = [],
) {

  validate_string($ensure)
  validate_re($ensure, ['present', 'absent'],
  "\$ensure must be either 'present' or 'absent', got '${ensure}'")

  validate_absolute_path($directory)

  if !is_array($exclude) and !is_string($exclude) {
    fail('$exclude must be of type String or Array')
  }

  include ::tmpreaper::params

  $exclude_params = join(prefix(suffix(flatten([$exclude]), '\''), "${::tmpreaper::params::exclude_option} '"), ' ')

  cron {"tmpreaper for ${directory} on ${user}":
    ensure  => $ensure,
    command => "${::tmpreaper::params::cmd} ${::tmpreaper::params::verbose_option} ${exclude_params} --mtime ${age} ${directory} 2>&1 | logger -t tmpreaper-${rtag}",
    hour    => $hour,
    minute  => $minute,
    require => Anchor['tmpreaper::end'],
    user    => $user,
  }
}
