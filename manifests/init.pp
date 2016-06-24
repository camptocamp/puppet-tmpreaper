class tmpreaper (
  $enabled = $tmpreaper::params::enabled,
  $package = $tmpreaper::params::package,
) inherits tmpreaper::params {

  validate_bool($enabled)
  validate_string($package)

  anchor {'tmpreaper::begin': } ->
  class {[
    'tmpreaper::install',
    'tmpreaper::config',
  ]:
  } ->
  anchor {'tmpreaper::end': }
}
