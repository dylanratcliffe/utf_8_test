class role::base (
  $ensure_utf_8_host = false,
  $ensure_japanase_files = false,
  $ensure_utf_8_users = false,
  $ensure_utf_8_group = false,
  $ensure_japanse_concat = false,
  $utf_8_notify_string = 'こんにちは',
) {

  class { 'profile::base':
    ensure_utf_8_host   => $ensure_utf_8_host,
    ensure_japanase_files  => $ensure_japanase_files,
    ensure_utf_8_users  => $ensure_utf_8_users,
    ensure_utf_8_group  => $ensure_utf_8_group,
    ensure_japanse_concat  => $ensure_japanse_concat,
    utf_8_notify_string => $utf_8_notify_string,
  }
}
