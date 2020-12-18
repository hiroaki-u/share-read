class BooksController < ApplicationController

  def show
    @book = Book.find_by(isbn: params[:id])
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
        @books << book
      end
    end
    @books.each do |book|
      book.save
    end
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])

    unless @book.present?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
  end

  private
  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    
    {
      title: title,
      url: url,
      isbn: isbn,
      image_url: image_url
    }
  end
end