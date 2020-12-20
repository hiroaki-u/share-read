class BooksController < ApplicationController

  def new
    @review = current_user.reviews.new
    @book = @review.book
  end

  def show
    @book = Book.find_by(isbn: params[:id])
    @book.id = @book.isbn
  end
  
  def search
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      results.each do |result|
        book = Book.new(read(result))
        bussiness_book_id = ["001001", "001005", "001006", "001008", "001028" ]
        if bussiness_book_id.any? {|i| book.book_genre_id.include?(i)}
          @books << book
        end
      end
    end
    @books.each do |book|
      book.save
      book.id = book.isbn
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
    {
      title: title,
      url: url,
      isbn: isbn,
      image_url: image_url,
      book_genre_id: book_genre_id
    }
  end
end