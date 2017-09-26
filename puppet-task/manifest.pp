#!/opt/puppetlabs/puppet/bin/puppet apply

file { '/tmp/bolt':
  ensure  => present,
  content => 'bolt hello world',
}
