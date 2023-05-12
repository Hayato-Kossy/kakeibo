class BooksController < ApplicationController
    def index
      @books = Book.all
      @books = @books.where(year: params[:year]) if params[:year].present?
      @books = @books.where(month: params[:month]) if params[:month].present?

    end
  
    def show 
      @book = Book.find(params[:id])
    end
  
    def new 
      @book = Book.new
    end
  
    def create 
      @book = Book.new(book_params)
      if @book.save
        redirect_to books_path, flash: { success: "家計簿を登録しました。" }
      else 
        render :new
      end
    end
  
    def edit 
      @book = Book.find(params[:id])
    end
  
    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to @book, flash: { success: "家計簿を更新しました。" }
      else
        render :edit
      end
    end
  
    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path, flash: { success: "家計簿を削除しました。" }
    end
  
    private
    def book_params
      params.require(:book).permit(:year, :month, :inout, :category, :amount)
    end
  end
    