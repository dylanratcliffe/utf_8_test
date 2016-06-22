class profile::app_services (
  $install_dir = '/opt/tomcat',
) {

  tomcat::install { $install_dir: }

}
