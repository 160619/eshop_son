# frozen_string_literal: true

namespace :db do
  desc 'TODO'
  task fake_data: :environment do
    mang = ['Samsung', 'Macbook', 'Asus', 'Acer', 'IPhone', 'IPad', "Dell", 'LG', 'HP', 'Lenovo']

      mang.each do |category_name|
        puts "creating category #{category_name}"
        category = Category.create(name: category_name)

        %w[p1 p2].each do |product_name|
        puts "creating product of category #{category_name}"
          Product.create(name: product_name, price: 1000, quantity: 3, category_id: category.id)
      end
    end
  end
end
