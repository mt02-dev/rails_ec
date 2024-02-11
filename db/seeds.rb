# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

product_count = Dir.children(Rails.root.join("app/assets/images/rails_ec_images/")).count
product_count.times do |i| 
  Product.create!(
    name: "Test Product #{i + 1}",
    price: 600,
    description: "This is descritpion of product #{i + 1}."
  )
end

products = Product.all
product_count.times do |i|
   
  products[i].product_image.attach(io: File.open(Rails.root.join("app/assets/images/rails_ec_images/image#{i + 1}.jpg")), filename: "image#{i + 1}.jpg")
  products[i].save!
end