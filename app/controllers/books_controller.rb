class BooksController < ApplicationController
  
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])

    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
  end
  
  def index; end

  def show; end

  def search
    if params[:title_search].nil? && params[:author_search].nil?
      return
    elsif params[:title_search].blank? && params[:author_search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    elsif params[:title_search] && (params[:author_search].nil? || params[:author_search].blank?)
      @books = RakutenWebService::Books::Book.search(title: params[:title_search])
    elsif params[:author_search] && (params[:title_search].nil? || params[:title_search].blank?)
      @books = RakutenWebService::Books::Book.search(author: params[:author_search])
    elsif params[:author_search] && params[:title_search]
      @books = RakutenWebService::Books::Book.search(title: params[:title_search], author: params[:author_search])
    end
    # # ここで空の配列を作ります
    # @books = []
    # @title = params[:title]
    # if @title.present?
    #   #この部分でresultsに楽天APIから取得したデータ（jsonデータ）を格納します。
    #   #今回は書籍のタイトルを検索して、一致するデータを格納するように設定しています。
    #   results = RakutenWebService::Books::Book.search({
    #     title: @title,
    #   })
    #   #この部分で「@books」にAPIからの取得したJSONデータを格納していきます。
    #   #read(result)については、privateメソッドとして、設定しております。
    #   results.each do |result|
    #     book = Book.new(read(result))
    #     @books << book
    #   end
    # end
    # #「@books」内の各データをそれぞれ保存していきます。
    # #すでに保存済の本は除外するためにunlessの構文を記載しています。
    # @books.each do |book|
    #   unless Book.all.include?(book)
    #     book.save
    #   end
    # end
  end

  private  

  def book_params
    params.require(:book).permit(:title, :sales_date, :medium_image_url, :item_url, :isbn)
  end

  def author_params
    params.require(:book).permit(author: [])
  end

  def read(result)
    title = result["title"]
    author = result["author"]
    item_url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    item_caption = result["itemCaption"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      item_caption: item_caption,
    }
  end
  
end