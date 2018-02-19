require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'



class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
 
	include ActionDispatch::TestProcess

  fixtures :all

 
	CarrierWave.root = 'test/fixtures/files'
end
