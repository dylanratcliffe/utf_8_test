class role::base (
  $ensure_japanese_host = false,
  $ensure_japanase_files = false,
  $ensure_japanese_users = false,
  $ensure_japanese_group = false,
  $ensure_japanse_concat = false,
  $japanese_notify_string = 'こんにちは',
) {

  class { 'profile::base':
    ensure_japanese_host   => $ensure_japanese_host,
    ensure_japanase_files  => $ensure_japanase_files,
    ensure_japanese_users  => $ensure_japanese_users,
    ensure_japanese_group  => $ensure_japanese_group,
    ensure_japanse_concat  => $ensure_japanse_concat,
    japanese_notify_string => $japanese_notify_string,
  }
}
