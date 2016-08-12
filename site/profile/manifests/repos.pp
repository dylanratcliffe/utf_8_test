class profile::repos {

  $repo_hash          = hiera_hash('profile::repos::repo_hash', undef)
  $repo_default_hash  = hiera('profile::repos::repo_default_hash', undef)
  $apt_hash           = hiera_hash('profile::repos::apt_hash', undef)
  $apt_default_hash   = hiera('profile::repos::apt_default_hash', undef)
  $collect_repos      = hiera('profile::repos::collect_repos', true)

  if $repo_hash and $repo_default_hash and $::os['family'] == 'RedHat' {
    # old school
    # create_resources('yumrepo', $repo_hash, $repo_default_hash)
    # new school
    $repo_hash.each |String $repo_name, Hash $repo_values_hash| {
      yumrepo { $repo_name:
        * => $repo_values_hash,;
        default:
          * => $repo_default_hash,;
      }
    }
  } elsif $apt_hash and $apt_default_hash and $::os['family'] == 'Debian' {
    $apt_hash.each |String $apt_name, Hash $apt_values_hash| {
      apt::source { $apt_name:
        * => $apt_values_hash,;
        default:
          * => $apt_default_hash,;
      }
    }
  }

  if $collect_repos and $::os['family'] == 'RedHat' {
    Yumrepo <<| |>>

    Yumrepo<| tag == 'custom_yum_packages'|> -> Package <| tag == 'custom' |>
  }
  if $collect_repos and $::os['family'] == 'Debian' {
    include apt
    Apt::Source <<| |>>

    Apt::Source<| tag == 'custom_apt_packages' |> -> Package<| tag == 'custom' |>
  }
}
