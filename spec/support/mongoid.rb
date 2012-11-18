RSpec.configure do |config|
  config.include Mongoid::Matchers
  config.include Devise::TestHelpers, :type => :controller
end