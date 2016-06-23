class role::app_server (
  $ensure_japanese_host = false,
  $ensure_japanase_files = true,
  $ensure_japanese_users = true,
  $ensure_japanese_group = true,
  $install_dir = '/opt/tomcat',
) {

  class { 'profile::base':
    ensure_japanese_host  => $ensure_japanese_host,
    ensure_japanase_files => $ensure_japanase_files,
    ensure_japanese_users => $ensure_japanese_users,
    ensure_japanese_group => $ensure_japanese_group,
  }
  class { 'profile::app_services':
    install_dir => $install_dir,
  }

}
