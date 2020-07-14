# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: 'admin@admin', password: 'adminadmin')
Customer.create!(email: "test@test", name: "test", account_name: "tester",tel: "1234567890",
	postcode: "1111111", address: "東京都", password: "testtest", is_active: "有効")

Shipping.create!(customer_id: 1, name: "test", postcode:"2222222", address:"大阪府")

Genre.create!(name: "葉菜類", introduction: "レタス・小松菜とか")
Genre.create!(name: "根菜類", introduction: "大根・かぼちゃとか")
Genre.create!(name: "果菜類", introduction: "ナス・トマトとか")

Product.create!(genre_id: 1, name: "レタス", price: 100, introduction: "レタスです", product_image_id: "", is_active: "販売中")
Product.create!(genre_id: 2, name: "大根", price: 200, introduction: "大根です", product_image_id: "", is_active: "販売中")
Product.create!(genre_id: 3, name: "トマト", price: 300, introduction: "トマトです", product_image_id: "", is_active: "販売中")

puts "+++++++++++"
puts "url "
puts "email: admin@admin"
puts "pass adminadmin"
puts "+++++++++++"