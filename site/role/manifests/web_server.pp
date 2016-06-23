class role::web_server (
  $ensure_japanese_host = false,
  $ensure_japanase_files = true,
  $ensure_japanese_users = true,
  $ensure_japanese_group = true,
) {

  class { 'profile::base':
    ensure_japanese_host  => $ensure_japanese_host,
    ensure_japanase_files => $ensure_japanase_files,
    ensure_japanese_users => $ensure_japanese_users,
    ensure_japanese_group => $ensure_japanese_group,
  }
  include profile::web_services
  include profile::puppet_users

}
