class profile::base (
  $ensure_utf_8_host      = false,
  $ensure_utf_8_files     = false,
  $ensure_utf_8_static    = false,
  $ensure_utf_8_users     = false,
  $ensure_utf_8_group     = false,
  $ensure_utf_8_concat    = false,
  $ensure_utf_8_nrp       = false,
  $ensure_utf_8_registry  = false,
  $utf_8_notify_string    = 'こんにちは',
)  {

  $user_array = hiera_array('profile::base::utf_8_user_array', undef)
  $file_hash  = hiera_hash('profile::base::ファイル＿配列', undef)

  class { 'utf_8':
    user_array          => $user_array,
    file_hash           => $file_hash,
    ensure_host         => $ensure_utf_8_host,
    ensure_static_files => $ensure_utf_8_static,
    ensure_files        => $ensure_utf_8_files,
    ensure_users        => $ensure_utf_8_users,
    ensure_group        => $ensure_utf_8_group,
    ensure_concat       => $ensure_utf_8_concat,
    ensure_registry     => $ensure_utf_8_registry,
    notify_string       => $utf_8_notify_string,
  }

  case $::kernel {
    'linux': {
      $sysctl_settings  = hiera('profile::base::sysctl_settings')
      $sysctl_defaults  = hiera('profile::base::sysctl_defaults')
      $mco_client_array = hiera_array('profile::base::mco_client_array', undef)
      $enable_firewall  = hiera('profile::base::enable_firewall',true)
      $user_hash        = hiera_hash('profile::base::user_hash')

      Firewall {
        before  => Class['profile::fw::post'],
        require => Class['profile::fw::pre'],
      }

      if $::os['family'] == 'Debian' and $ensure_utf_8_nrp {
        class { 'utf_8::puppet_users':
          user_hash => $user_hash,
        }
      }

      if $enable_firewall {
        class { 'firewall':
        }
        class {['profile::fw::pre','profile::fw::post']:
        }
        firewall { '100 allow ssh access':
          port   => '22',
          proto  => 'tcp',
          action => 'accept',
        }
      } else {
        class { 'firewall':
          ensure => stopped,
        }
      }

      require profile::time_locale

      # old way
      # create_resources(sysctl,$sysctl_settings, $sysctl_defaults)
      # new way
      $sysctl_settings.each |String $sysctl_name, Hash $sysctl_hash| {
        sysctl { $sysctl_name:
          * => $sysctl_hash,;
          default:
            * => $sysctl_defaults,;
        }
      }

      ensure_packages(['ruby'])

    }
    'windows': {

      $wsus_server      = hiera('profile::base::wsus_server')
      $wsus_server_port = hiera('profile::base::wsus_server_port')

      file { ['C:/ProgramData/PuppetLabs/facter','C:/ProgramData/PuppetLabs/facter/facts.d']:
        ensure => directory,
      }

      acl { ['C:/ProgramData/PuppetLabs/facter','C:/ProgramData/PuppetLabs/facter/facts.d']:
        purge                      => false,
        permissions                => [
         { identity => 'vagrant', rights => ['full'], perm_type=> 'allow', child_types => 'all', affects => 'all' },
         { identity => 'Administrators', rights => ['full'], perm_type=> 'allow', child_types => 'all', affects => 'all'}
        ],
        owner                      => 'vagrant',
        group                      => 'Administrators',
        inherit_parent_permissions => true,
      }

      # setup wsus client
      class { 'wsus_client':
        server_url => "${wsus_server}:${wsus_server_port}",
      }
    }
  }

}
