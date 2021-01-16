# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    isbn { Faker::Number.number(digits: 4) }
    title { Faker::Book.title }
    author { Faker::Book.author }
    url { Faker::Internet.url }
    image_url { Faker::Internet.url }
    book_genre_id { Faker::Number.number(digits: 4) }
    caption { Faker::String.random }
  end
end
