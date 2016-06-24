# Definition: tmpreaper::directory
#       Create or remove a cronjob for a specific directory
# Parameters:
#       directory: mandatory - absolute path to directory
#       rtag: mandatory  - process tag for syslog
#       age: optional    - set max age for files in directory
#       hour: optional   - set cron hour
#       minute: optional - set cron minute
#       user: optional   - set cron user
define tmpreaper::directory(
  $directory,
  $rtag,
  $ensure = 'present',
  $age    = '1w',
  $hour   = undef,
  $minute = undef,
  $user   = 'root',
) {

  validate_string($ensure)
  validate_re($ensure, ['present', 'absent'],
  "\$ensure must be either 'present' or 'absent', got '${ensure}'")

  validate_absolute_path($directory)

  include ::tmpreaper::params

  cron {"tmpreaper for ${directory} on ${user}":
    ensure  => $ensure,
    command => "${::tmpreaper::params::cmd} --showdeleted --mtime ${age} ${directory} 2>&1 | logger -t tmpreaper-${rtag}",
    hour    => $hour,
    minute  => $minute,
    require => Anchor['tmpreaper::end'],
    user    => $user,
  }
}
