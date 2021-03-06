class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def new
     
  end

  def create
     @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book)
    flash[:success] = 'You have created book successfully.'
    else
     @books = Book.all
     @user = current_user
    render :index
    end
  end

  def index
     @newbook = Book.new
     @users = User.all
     @user = current_user
  end

  def show
    @newbook = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(current_user.id)
    flash[:success] = ' You have updated user successfully.'
   else
   render :edit
   end
  end
  def destroy
     book = Book.find(params[:id])
    book.destroy
    redirect_to  user_path(@user.id)
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless  @user == current_user
    redirect_to user_path(current_user)
    end
  end
end