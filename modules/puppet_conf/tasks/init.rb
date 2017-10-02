#!/opt/puppetlabs/puppet/bin/ruby
require 'json'
require 'open3'
require 'puppet'

def set(setting, section, value)
  cmd_string = "puppet config set #{setting} #{value}"
  cmd_string << " --section #{section}" unless section.nil?
  _stdout, stderr, status = Open3.capture3(cmd_string)
  raise Puppet::Error, stderr if status != 0
  { status: value, setting: setting, section: section }
end

def get(setting, section, _value)
  cmd_string = "puppet config print #{setting}"
  cmd_string << " --section #{section}" unless section.nil?
  stdout, stderr, status = Open3.capture3(cmd_string)
  raise Puppet::Error, stderr if status != 0
  { status: stdout.strip, setting: setting, section: section }
end

params = JSON.parse(STDIN.read)
action = params['action']
setting = params['setting']
section = params['section']
value = params['value']
section = 'main' if section.nil?

begin
  result = if action == 'get'
             get(setting, section, value)
           else
             raise Puppet::Error, 'You must pass a value argument' if value.nil?
             set(setting, section, value)
           end
  puts result.to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end
