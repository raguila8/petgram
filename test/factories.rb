FactoryBot.define do
  factory :post do
    description "My Brand"
    profile_id 5
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/test/fixtures/files/test1.jpg')))
	end
end
