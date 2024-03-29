# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates_uniqueness_of :review_id, scope: :user_id
end
