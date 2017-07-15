RSpec.configure do |config|
  config.before do
    ENV['ABLY_API_KEY'] = 'test.test:test-test'
  end
end
