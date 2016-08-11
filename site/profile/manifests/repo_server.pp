class profile::repo_server {

  $repo_data      = hiera_hash('profile::repo_server::repo_data')
  $repo_defaults  = hiera('profile::repo_server::repo_defaults')
  $apt_data       = hiera_hash('profile::repo_server::apt_data')
  $apt_defaults   = hiera('profile::repo_server::apt_defaults')

  include profile::web_services

  $repo_data.each |String $repo_name, Hash $repo_hash| {
    @@yumrepo { $repo_name:
      * => $repo_hash,;
      default:
        * => $repo_defaults,;
    }
  }
  $apt_data.each |String $apt_name, Hash $apt_hash| {
    @@apt::source { $apt_name:
      * => $apt_hash,;
      default:
        * => $apt_defaults,;
    }
  }

  # The following is purely for this Vagrant env
  file { '/var/www/custom':
    ensure => link,
    target => '/vagrant/repo/custom',
  }

  file { '/var/www/apt':
    ensure => link,
    target => '/vagrant/repo/apt',
  }

}
