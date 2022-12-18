class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
    def index
        @user = current_user
        @users = User.all
        @books = @user.books
        @book = Book.new
    end
    
    #def create
        #book = Book.new(book_params)
       #if book.save
           #flash[:notice] = "Book was successfully created." 
          # redirect_to'/books/new'
       #else
          #render :new
       #end
       # @user = User.new(user_params)
        #if @user.save
            #flash[:success] = 'Signed in successfully.'
           #redirect_to login_path 
        #else
          #flash.now[:danger] = 'ユーザー登録に失敗しました'
          #render :new 
        #end    
    #end


    
    
    def show
        @user=User.find(params[:id])
        @book = Book.new
        @books= @user.books
    end
    
    def new
       @user = User.new
    end
    
    def edit
        @user = User.find(params[:id])
         #redirect_to root_path unless current_user.id == @user.user_id
    end
    
    def update
        @user = User.find(params[:id])#ユーザーの取得
        #ユーザーのアップデート
        
        if @user.update(user_params)
            redirect_to user_path(@user.id)#ユーザーの詳細ページへのパス
            flash[:notice] = "You have updated user successfully."
        else
           render("users/edit")
        end
    end
    
    def destroy
      session.delete(:user_id)
      @current_user = nil
      flash[:alert] = "Signed out successfully."
      redirect_to :root
    end
    
    def books
    	@users = User.all
    	@book = Book.new
    	@books = Book.all
    end
   
private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
   def correct_user
    @user = User.find(params[:id])
    unless current_user==@user
    redirect_to user_path(current_user)
    end
   end
end
