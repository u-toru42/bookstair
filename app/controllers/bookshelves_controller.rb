class BookshelvesController < ApplicationController
  before_action :set_target_bookshelf, only: %i[show edit update destroy]

  def index
    @bookshelves = Bookshelf.all
  end

  def new
    @bookshelf = Bookshelf.new
  end

  def create
    @bookshelf = Bookshelf.new(bookshelf_params)
    @bookshelf.save!
    redirect_to bookshelves_url, notice: "本棚を保存しました"
  end

  def show; end

  def edit; end

  def update
    @bookshelf.update(bookshelf_params)
    redirect_to @bookshelf, notice: "本棚を更新しました"
  end

  def destroy
    @bookshelf.destroy
    redirect_to bookshelves_path, danger: "「#{@bookshelf[:title]}」を削除しました。", status: :see_other 
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:title)
  end

  def set_target_bookshelf
    @bookshelf = Bookshelf.find(params[:id])
  end
end
