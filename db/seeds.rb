# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


EventType.create(name: "Concert")
# EventType.create(name: "Comedy")
EventType.create(name: "Festival")
# EventType.create(name: "Theatre")

Location.create(name: "Allianz Park")
Location.create(name: "Espaço Unimed")
Location.create(name: "Vibra São Paulo")
