class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def new
    @book = Book.new
  end
  
  def create
    @book= Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
     flash[:notice] = "You have created book successfully." 
    redirect_to book_path(@book.id)
   else
     flash[:alret] = "投稿に失敗しました。"
     @books = Book.all
     @user = current_user
     render :index
   end
  end

  def index
    @books= Book.all
    @book= Book.new
    @user= current_user
  end

  def show
     @book=Book.find(params[:id])
     @book_new= Book.new
     @user= current_user
  end


  def update
    @book=Book.find(params[:id]) 
    @book.user_id = current_user.id
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      flash[:alret] = "投稿に失敗しました。"
    render :new
    end
  end 
  
  def edit
     @book= Book.find(params[:id])
     @user= current_user
  end
  
  def destroy
    @book= Book.find(params[:id])
    @book.destroy
      flash[:notice] = "Book was successfully destroyed."  
     redirect_to books_path, alert: '投稿を削除しました'
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end