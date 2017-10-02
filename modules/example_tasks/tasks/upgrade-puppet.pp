#!/opt/puppetlabs/bin/puppet apply

package{'puppet-agent':
  ensure => latest,
  notify => 'Service[Puppet-agent]'
}

service{'puppet-agent':
  ensure => running,
}
