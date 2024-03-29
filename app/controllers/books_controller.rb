# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :require_login, only: %i[show]

  def show
    @book = Book.find_by(isbn: params[:id])
    @bookcase = Bookcase.new
    @reviews = @book.reviews.where(status: 1).order(updated_at: :desc).page(params[:page]).per(6)
    @review = current_user.reviews.new
  end

  def search
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({ title: @title })
      results.each do |result|
        book = Book.new(read(result))
        bussiness_book_id = %w[001001 001005 001006 001008 001028]
        @books << book if bussiness_book_id.any? { |i| book.book_genre_id.include?(i) }
      end
    end
    @books.each do |book|
      book.save unless Book.all.include?(book)
    end
  end

  private

  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    book_genre_id = result["booksGenreId"]
    caption = result["itemCaption"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      book_genre_id: book_genre_id,
      caption: caption
    }
  end
end
