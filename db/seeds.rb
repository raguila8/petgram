# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(username: "raguila8", email: "rodrigoaguilar887@gmail.com", password: "foobar", password_confirmation: "foobar")
user.save
Profile.create!(user_id: user.id, name: "Choco", username: "raguila8", bio: "I am a brown dog", animal: "Dog")

20.times do |n|
	username = Faker::Internet.user_name
	email = Faker::Internet.email
	user = User.new(username: username, email: email, password: "password", password_confirmation: "password")
	while (!user.save)
		username = Faker::Internet.user_name
		email = Faker::Internet.email
		user = User.new(username: username, email: email, password: "password", password_confirmation: "password")
	end
	animal = Faker::Pokemon.name
	name = Faker::Name.first_name
	bio = Faker::Lorem.sentence
	num = rand(115) + 1
	profile_image = File.open(File.join(Rails.root, "/public/profile_icons/#{num}.png"))
	Profile.create(user_id: user.id, name: name, animal: animal, username: user.username, bio: bio, profile_image: profile_image)
end

# Following relationships
profiles = Profile.all
profile  = profiles.first
following = profiles[2..19]
followers = profiles[3..19]
following.each { |followed| profile.follow(followed) }
followers.each { |follower| follower.follow(profile) }

