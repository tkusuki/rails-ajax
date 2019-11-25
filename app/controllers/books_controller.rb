class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
        format.js {}
      else
        format.html { render action: "new" }
        format.js {}
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_path, notice: 'Book was deleted!' }
      format.js {}
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :description, :author)
  end
end
