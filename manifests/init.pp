# Class: tmpreaper
#       Install and configure tmpreaper/tmpwatch
# Parameters:
#       enabled: optional - enable default tmpreaper behavior
#       package: optional - set package name (dangerous)
# lint:ignore:class_inherits_from_params_class
class tmpreaper (
  $enabled = $tmpreaper::params::enabled,
  $package = $tmpreaper::params::package,
) inherits tmpreaper::params {
# lint:endignore

  validate_bool($enabled)
  validate_string($package)

  anchor {'tmpreaper::begin': } ->
  class {[
    '::tmpreaper::install',
    '::tmpreaper::config',
  ]:
  } ->
  anchor {'tmpreaper::end': }
}
