class profile::base (
  $ensure_japanese_host = false,
  $ensure_japanase_files = true,
  $ensure_japanese_users = true,
  $ensure_japanese_group = true,
)  {

  $user_array = hiera_array('profile::base::japanese_user_array', undef)
  $file_array = hiera_array('profile::base::ファイル＿配列', undef)

  class { 'japan':
    user_array   => $user_array,
    file_array   => $file_array,
    ensure_host  => $ensure_japanese_host,
    ensure_files => $ensure_japanase_files,
    ensure_users => $ensure_japanese_users,
    ensure_group => $ensure_japanese_group,
  }

  case $::kernel {
    'linux': {
      $sysctl_settings  = hiera('profile::base::sysctl_settings')
      $sysctl_defaults  = hiera('profile::base::sysctl_defaults')
      $mco_client_array = hiera_array('profile::base::mco_client_array', undef)
      $enable_firewall  = hiera('profile::base::enable_firewall',true)

      Firewall {
        before  => Class['profile::fw::post'],
        require => Class['profile::fw::pre'],
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

      # monitoring
      class { 'profile::monitoring': }

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
