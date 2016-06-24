class role::base (
  $ensure_japanese_host = false,
  $ensure_japanase_files = true,
  $ensure_japanese_users = true,
  $ensure_japanese_group = true,
  $ensure_japanse_concat = false,
) {

  class { 'profile::base':
    ensure_japanese_host  => $ensure_japanese_host,
    ensure_japanase_files => $ensure_japanase_files,
    ensure_japanese_users => $ensure_japanese_users,
    ensure_japanese_group => $ensure_japanese_group,
    ensure_japanse_concat => $ensure_japanse_concat,
  }
}
