# frozen_string_literal: true

class BookcasesController < ApplicationController
  before_action :require_login
  before_action :set_book

  def create
    current_user.register(@book)
  end

  def destroy
    current_user.unregister(@book)
  end

  private

  def set_book
    @book = Book.find_by(isbn: params[:book_id])
  end
end
