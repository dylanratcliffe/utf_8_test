
node default {
}

site {
  # utf_8::app { 'ブランク':
  #   nodes => {
  #     Node['node0.puppet.vm'] => Utf_8::Component_one['ブランク_first'],
  #     Node['node1.puppet.vm'] => Utf_8::Component_one['ブランク_second'],
  #   },
  # }

  utf_8::app { 'English':
    message => fqdn_rand_string('10'),
    nodes   => {
      Node['node0.puppet.vm'] => Utf_8::Component_one['English_first'],
      Node['node1.puppet.vm'] => Utf_8::Component_one['English_second'],
    },
  }
}
