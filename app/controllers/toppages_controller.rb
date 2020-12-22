class ToppagesController < ApplicationController
  def index
    @reviews = Review.all.order(updated_at: :desc)
  end
end
