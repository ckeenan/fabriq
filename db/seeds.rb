# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




User.create([
	{name: "Admin", email: "admin@example.com", reputation: 20, avatar: File.open(File.join(Rails.root, "/app/assets/images/avatar.jpg")), password: "admin", password_confirmation: "admin", tribe_id: 1},
	{name: "Sean Carter", email: "sean@example.com", reputation: 50, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_01.jpg")), password: "admin", password_confirmation: "admin", tribe_id: 2},
	{name: "Stephen Hawking", email: "stephen@example.com", reputation: 40, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_02.jpg")), password: "admin", password_confirmation: "admin", tribe_id: 1},
	{name: "Noam Chomsky", email: "noam@example.com", reputation: 35, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_03.jpg")), password: "admin", password_confirmation: "admin", tribe_id: 2},
	{name: "Camping Circus", email: "camping@example.com", reputation: 15, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_04.jpg")), password: "admin", password_confirmation: "admin"},
	{name: "Johnny Cash", email: "johnny@example.com", reputation: 5, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_05.jpg")), password: "admin", password_confirmation: "admin"},
	{name: "Trailblazers", email: "admin@example.com", reputation: 20, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_06.jpg")), password: "admin", password_confirmation: "admin"},
	{name: "Stage X", email: "stage@example.com", reputation: 27, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_07.jpg")), password: "admin", password_confirmation: "admin"},
	{name: "Valley", email: "valley@example.com", reputation: 43, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_08.jpg")), password: "admin", password_confirmation: "admin"},
	{name: "Plaza Central", email: "plaza@example.com", reputation: 35, avatar: File.open(File.join(Rails.root, "/app/assets/images/persona_09.jpg")), password: "admin", password_confirmation: "admin"},
	{name: "Wildcard", email: "wildcard@example.com", reputation: 20, avatar: File.open(File.join(Rails.root, "/app/assets/images/trailblazer.jpg")), password: "admin", password_confirmation: "admin"}
])

Badge.create([
	{name: "Badge One", icon: "icon"},
	{name: "Badge Two", icon: "icon"},
	{name: "Badge Three", icon: "icon"},
	{name: "Badge Four", icon: "icon"}
])

Tribe.create([
	{name: "Tribe of One", desc: "This is the first tribe."},
	{name: "Tribe of Two", desc: "This is the second tribe."}
])