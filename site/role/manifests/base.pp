class role::base (
  $ensure_utf_8_host      = false,
  $ensure_utf_8_files     = false,
  $ensure_utf_8_static    = false,
  $ensure_utf_8_users     = false,
  $ensure_utf_8_group     = false,
  $ensure_utf_8_concat    = false,
  $ensure_utf_8_nrp       = false,
  $ensure_utf_8_registry  = false,
  $ensure_utf_8_exported  = false,
  $ensure_utf_8_virtual   = false,
  $ensure_utf_8_lookup    = false,
  $utf_8_notify_string    = 'こんにちは',
) {

  class { 'profile::base':
    ensure_utf_8_host     => $ensure_utf_8_host,
    ensure_utf_8_files    => $ensure_utf_8_files,
    ensure_utf_8_static   => $ensure_utf_8_static,
    ensure_utf_8_users    => $ensure_utf_8_users,
    ensure_utf_8_group    => $ensure_utf_8_group,
    ensure_utf_8_concat   => $ensure_utf_8_concat,
    ensure_utf_8_nrp      => $ensure_utf_8_nrp,
    ensure_utf_8_registry => $ensure_utf_8_registry,
    ensure_utf_8_exported => $ensure_utf_8_exported,
    ensure_utf_8_virtual  => $ensure_utf_8_virtual,
    ensure_utf_8_lookup   => $ensure_utf_8_lookup,
    utf_8_notify_string   => $utf_8_notify_string,
  }
}
