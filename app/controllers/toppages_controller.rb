# frozen_string_literal: true

class ToppagesController < ApplicationController
  def index
    @reviews = Review.where(status: 1).includes(:book, :user).order(updated_at: :desc)
  end
end
