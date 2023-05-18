class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]
    before_action :redirect_to_signin
    def index
      @books = Book.where(user_id: session[:user_id])
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
      book_params = params.require(:book).permit(:year, :month, :inout,
      :category, :amount)
      book_params[:user_id] = session[:user_id]
      @book = Book.new(book_params)
      if @book.save
        flash[:notice] = "家計簿にデータを1件登録しました"
        redirect_to books_path
      else
        flash.now[:alert] = "登録に失敗しました。"
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

    def set_book
      @book = Book.where(user_id: session[:user_id]).find(params[:id])
    end

    def redirect_to_signin
      redirect_to signin_path if session[:user_id].blank?
    end
end
    