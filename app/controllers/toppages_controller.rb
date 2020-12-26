class ToppagesController < ApplicationController
  def index
    @reviews = Review.where(status: 1).order(updated_at: :desc)
  end
end
