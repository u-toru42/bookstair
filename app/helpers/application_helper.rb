module ApplicationHelper
  def rakuten_book_thumbnail(book)
    book['mediumImageUrl'] == "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/noimage_01.gif?_ex=120x120" ? 'no_image.png' : book['mediumImageUrl']
  end

  def set_rakuten_book_params(book)
    #volumeInfoの中が必要な項目のみになるようsliceを使って絞りこむ
    book['item'].slice('title', 'author', 'salesDate', 'mediumImageUrl', 'itemUrl', 'isbn')
  end
end
