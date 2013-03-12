require 'rubygems'
require 'bundler'
Bundler.require :test

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'fakie'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end

class Fakie::TestCase < MiniTest::Unit::TestCase
end
