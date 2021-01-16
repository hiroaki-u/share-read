# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    content  { Faker::String.random(length: 1..1200) }
    status { 0 }
    association :user
    association :book
  end
end
