require "time"
require 'rspec/given'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock 
end

RSpec.configure do |config|
  config.mock_with :flexmock
end
$: << File.join(File.dirname(__FILE__),'../app/models')
$: << File.join(File.dirname(__FILE__),'../app/domain')
$: << File.join(File.dirname(__FILE__),'../lib')
