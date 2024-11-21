# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
VALID_COMPETENCES = %w[Analyse Créativité Logique Mémoire Communication Apprentissage Gestion_émotionnelle]

20.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Name.name)
end

30.times do
  latitude = rand(42..50)
  longitude = rand(0..9)
  geocoded_result = Geocoder.search([latitude, longitude]).first
  address = geocoded_result ? geocoded_result.address : "Unknown address"
  Brain.create!(name: Faker::Lorem.sentence, price: Faker::Number.number(digits: 2), address: address, latitude: latitude, longitude: longitude, user: User.all.sample, competence: VALID_COMPETENCES.sample)
end

20.times do
  Booking.create!(confirmation: false, user: User.all.sample, brain: Brain.all.sample, start_date: Faker::Date.forward(days: 15), end_date: Faker::Date.forward(days: 30))
end
