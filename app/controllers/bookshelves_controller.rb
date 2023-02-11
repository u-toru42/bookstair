class BookshelvesController < ApplicationController
  before_action :set_target_bookshelf, only: %i[show edit update destroy]

  def index
<<<<<<< Updated upstream
    @bookshelves = Bookshelf.all
  end

  def new
    @bookshelf = Bookshelf.new
=======
    @bookshelves = params[:tag_id].present? ? Tag.find(params[:tag_id]).bookshelves : Bookshelf.all
    @bookshelves = @bookshelves.page(params[:page]).per(10)
    # binding.irb 
  end

  def new
    @bookshelf = Bookshelf.new(flash[:bookshelf])
>>>>>>> Stashed changes
  end

  def create
    @bookshelf = Bookshelf.new(bookshelf_params)
<<<<<<< Updated upstream
    @bookshelf.save!
    redirect_to bookshelves_url, notice: "本棚を保存しました"
  end

  def show; end
=======
    if @bookshelf.save
      redirect_to bookshelves_url, notice: "「#{@bookshelf.title}」の本棚を作成しました。"
    else
      flash[:bookshelf] = @bookshelf
      flash[:error_messages] = @bookshelf.errors.full_messages
      redirect_to new_bookshelf_path
    end
  end

  def show
    # @comment = @bookshelf.comments.new
    @comment = Comment.new(bookshelf_id: @bookshelf.id)
  end
>>>>>>> Stashed changes

  def edit; end

  def update
<<<<<<< Updated upstream
    @bookshelf.update(bookshelf_params)
    redirect_to @bookshelf, notice: "本棚を更新しました"
=======
    if @bookshelf.update(bookshelf_params)
      redirect_to @bookshelf, notice: "本棚を更新しました"
    else
      flash[:bookshelf] = @bookshelf
      flash[:error_messages] = @bookshelf.errors.full_messages
      redirect_back fallback_location: edit_bookshelf_path
    end
>>>>>>> Stashed changes
  end

  def destroy
    @bookshelf.destroy
    redirect_to bookshelves_path, danger: "「#{@bookshelf[:title]}」を削除しました。", status: :see_other 
  end

  private

  def bookshelf_params
<<<<<<< Updated upstream
    params.require(:bookshelf).permit(:title)
=======
    params.require(:bookshelf).permit(:title, tag_ids: [])
>>>>>>> Stashed changes
  end

  def set_target_bookshelf
    @bookshelf = Bookshelf.find(params[:id])
  end
end
