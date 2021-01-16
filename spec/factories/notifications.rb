# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    association :visited, factory: :user
    association :visitor, factory: :user
    association :review
    association :comment
    checked { false }
  end
end
