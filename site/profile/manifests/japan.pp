class profile::japan {

  $user_array = hiera_array('profile::japan::user_array')

  # This class is not best practises, it is for testing only.
  case $::kernel {
    'Linux': {
      $user_path = '/home/'
      $user_gid  = 'オージー'
      $user_groups = undef
    }
    'Windows': {
      $user_path = 'C:\\Users\\'
      $user_gid  = undef
      $user_groups = 'オージー'
    }
    default: {
      fail("Oh, I am sorry you are using some shitty OS")
    }
  }

  host { 'ブレット.puppet.vm':
    ensure       => present,
    ip           => '52.10.10.141',
    host_aliases => ['ブレット'],
  }

  $user_array.each |String $user_name| {
    user { $user_name:
      ensure  => present,
      home    => "${user_path}${user_name}",
      gid     => $user_gid,
      groups  => $user_groups,
    }

    file { "${user_path}${user_name}":
      ensure => directory,
      owner  => $user_name,
      group  => $user_name,
      mode   => '0700',
    }

    if $os['family'] == 'Windows' {
      acl { "${user_path}${user_name}":
        purge                      => false,
        permissions                => [
         { identity => $user_name, rights => ['full'], perm_type=> 'allow', child_types => 'all', affects => 'all' },
        ],
        owner                      => $user_name,
        group                      => $user_name,
        inherit_parent_permissions => false,
      }
    }
  }

  group { 'オージー':
    ensure => present,
  }
}
