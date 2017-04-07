# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create default admin login
Admin.create(email: 'admin@gmail.com',password: '123456')

# create default cities for cleaners and customers
City.create!(name: 'Admedabad')
City.create!(name: 'Maninagar')
City.create!(name: 'Nadiyad')
City.create!(name: 'Anand')
City.create!(name: 'Baroda')
City.create!(name: 'Bharuch')
City.create!(name: 'Ankleshvar')
City.create!(name: 'Surat')
City.create!(name: 'Navsari')
City.create!(name: 'Valsad')
