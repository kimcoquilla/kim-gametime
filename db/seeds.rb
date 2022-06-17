# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Game.destroy_all

Game.create(name: 'English Word', description: 'Enter a valid English Word')
Game.create(name: 'Racing', description: 'First to reach finish line wins')
Game.create(name: 'Guess the Capital City', description: 'Enter the capital city of the given country')

puts 'Games created'
