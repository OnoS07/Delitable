# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: 'admin@admin', password: 'adminadmin')
Customer.create!(email: 'test@test', name: 'test', account_name: 'tester', tel: '1234567890',
                 postcode: '1111111', address: '京都府', password: 'testtest', is_active: '有効')
Customer.create!(email: 'gest@gest', name: 'gest', account_name: 'ゲスト', tel: '11122223333',
                 postcode: '1234567', address: '大阪府', password: ' gestgest', is_active: '有効')

Shipping.create!(customer_id: 1, name: 'test_shipping', postcode: '2222222', address: '大阪府')

Genre.create!(name: '葉菜類', introduction: 'レタス・小松菜とか')
Genre.create!(name: '根菜類', introduction: '大根・かぼちゃとか')
Genre.create!(name: '果菜類', introduction: 'ナス・トマトとか')
Genre.create!(name: '季節の野菜', introduction: 'シーズンに合わせて内容変更')
Genre.create!(name: 'セット', introduction: 'お得な詰め合わせ')

Product.create!(genre_id: 1, name: 'ブロッコリー', price: 150, introduction: 'ブロッコリーです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 1, name: '玉ねぎ', price: 50, introduction: '玉ねぎです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 1, name: 'ほうれん草', price: 150, introduction: 'ほうれん草です', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 1, name: 'アスパラガス', price: 200, introduction: 'アスパラガスです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 1, name: 'レタス', price: 100, introduction: 'レタスです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 1, name: 'キャベツ', price: 100, introduction: 'レタスです', product_image_id: '', is_active: '販売中')

Product.create!(genre_id: 2, name: 'カブ', price: 150, introduction: 'カブです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 2, name: 'じゃがいも', price: 50, introduction: 'じゃがいもです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 2, name: 'にんじん', price: 100, introduction: 'にんじんです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 2, name: '大根', price: 200, introduction: '大根です', product_image_id: '', is_active: '販売中')

Product.create!(genre_id: 3, name: 'オクラ', price: 200, introduction: 'オクラです。スタミナ不足の夏にぴったりの野菜です', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 3, name: 'パプリカ', price: 200, introduction: 'パプリカです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 3, name: 'ズッキーニ', price: 150, introduction: 'ズッキーニです', product_image_id: '', is_active: '販売中')

Product.create!(genre_id: 4, name: 'ゴーヤ', price: 300, introduction: 'ゴーヤです。旬の野菜なので、今が美味しいです', product_image_id: '', is_active: '販売中')
Product.create!(genre_id: 4, name: 'トマト', price: 200, introduction: 'トマトです。夏が一番美味しい野菜です', product_image_id: '', is_active: '販売中')

Product.create!(genre_id: 5, name: '緑の野菜詰め合わせ', price: 800, introduction: 'ブロッコリー・ほうれん草・オクラ・ゴーヤなど。緑の野菜はカロテン、ビタミン、ミネラルがたっぷり入っています', product_image_id: '', is_active: '販売中')

puts '+++++++++++'
puts 'admin-email: admin@admin'
puts 'admin-pass: adminadmin'
puts '+++++++++++'
