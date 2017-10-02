#!/opt/puppetlabs/puppet/bin/ruby
require 'json'

params = JSON.parse(STDIN.read)

puts {"value": params['data'][params['key']]}.to_json
