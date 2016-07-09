
node default {
}

site {
  utf_8::application { 'ブランク':
    nodes => {
      Node['node0.puppet.vm'] => Utf_8::Component_one['ブランク_first'],
      Node['node1.puppet.vm'] => Utf_8::Component_one['ブランク_second'],
    },
  }
}
