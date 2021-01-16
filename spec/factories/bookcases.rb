# frozen_string_literal: true

FactoryBot.define do
  factory :bookcase do
    association :user
    association :book
  end
end
