class role::app_server (
  $install_dir = '/opt/tomcat',
) {

  require profile::base
  class { 'profile::app_services':
    install_dir => $install_dir,
  }

}
