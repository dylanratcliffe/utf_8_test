
node default {
}

site {
  utf_8::app { 'ブランク':
    nodes => {
      Node['node0.puppet.vm'] => Utf_8::Component_one['ブランク_first'],
      Node['node1.puppet.vm'] => Utf_8::Component_one['ブランク_second'],
    },
  }

  utf_8::app { 'English':
    nodes => {
      Node['node0.puppet.vm'] => Utf_8::Component_one['English_first'],
      Node['node1.puppet.vm'] => Utf_8::Component_one['English_second'],
    },
  }
}
