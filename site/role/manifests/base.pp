class role::base (
  $ensure_utf_8_host   = false,
  $ensure_utf_8_files  = false,
  $ensure_utf_8_users  = false,
  $ensure_utf_8_group  = false,
  $ensure_utf_8_concat = false,
  $utf_8_notify_string = 'こんにちは',
) {

  class { 'profile::base':
    ensure_utf_8_host   => $ensure_utf_8_host,
    ensure_utf_8_files  => $ensure_utf_8_files,
    ensure_utf_8_users  => $ensure_utf_8_users,
    ensure_utf_8_group  => $ensure_utf_8_group,
    ensure_utf_8_concat => $ensure_utf_8_concat,
    utf_8_notify_string => $utf_8_notify_string,
  }
}
