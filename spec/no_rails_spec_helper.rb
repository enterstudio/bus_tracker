require "time"
require 'rspec/given'
RSpec.configure do |config|
    config.mock_with :flexmock
end
$: << File.join(File.dirname(__FILE__),'../app/models')
$: << File.join(File.dirname(__FILE__),'../app/domain')
$: << File.join(File.dirname(__FILE__),'../lib')
