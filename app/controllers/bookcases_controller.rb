class BookcasesController < ApplicationController
  before_action :require_login
  before_action :set_book

  def create
    if current_user.register(@book)
      flash[:success] = "登録完了"
    else
      flash[:success] = "失敗です"
    end
  end

  def destroy
    current_user.unregister(@book)
  end

  private
  def set_book
    @book = Book.find_by(isbn: params[:book_id])
  end
end
