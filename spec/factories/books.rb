# == Schema Information
#
# Table name: books
#
#  author          :string
#  isbn            :bigint           not null, primary key
#  item_caption    :text
#  item_price      :string
#  item_url        :text
#  large_image_url :text
#  sales_date      :text
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :book do
    isbn { Faker::Number.number(digits: 13).to_s }
    title { Faker::Book.title }
    author { Faker::Book.author }
    sales_date { Faker::Date.backward(days: 14) }
    large_image_url { Faker::Internet.url }
    item_url { Faker::Internet.url }
    item_caption { 'Sample caption' }
    item_price { Faker::Commerce.price(range: 10..100.0).to_s }
  end
end
