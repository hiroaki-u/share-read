# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::String.random(length: 1..255) }
    association :user
    association :review
  end
end
