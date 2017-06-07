require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) { WebMock.disable_net_connect!(allow: 'api.codacy.com') }
end
