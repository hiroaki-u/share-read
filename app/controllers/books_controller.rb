class BooksController < ApplicationController
  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    else
      flash[:notice] = "検索結果はありませんでした"
    end
  end

  def show
  end
end