require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
 
	include ActionDispatch::TestProcess

  fixtures :all

	if Rails.env.test?
		
		Minitest.after_run {
			FileUtils.rm_rf(Dir["#{Rails.root}/public/test/uploads"])
		}
	end

end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.default_driver = :selenium_chrome
		# Worst case
		Capybara.default_max_wait_time = 20
  end
end
