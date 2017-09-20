#!/usr/bin/env ruby

require 'yaml'
require 'optparse'

options = { }

OptionParser.new do |opts|
  opts.banner = "Usage: boltmap.rb [options] file"

  opts.on("-g", "--group=", "Map group to run") do |g|
    options[:group] = g
  end
end.parse!

boltyaml = YAML.load(ARGF)

hosts = []
if options[:group].nil?
  boltyaml.keys.each { |b| hosts << boltyaml[b] }
else
  hosts = boltyaml[options[:group]]
end

puts hosts.flatten.join(',')
