class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

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
     @book = Book.new
     @books = Book.all
     @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
     
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
   if  @book.update(book_params)
    redirect_to book_path(@book)
    flash[:success] = 'Book was successfully updated.'
   else
     render :edit
   end
  end
  def destroy
     book = Book.find(params[:id])
    book.destroy
    redirect_to  books_path
  end
  
   private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_user
    @books = Book.find(params[:id])
    unless  @books.user_id == current_user.id
    redirect_to books_path
    end
  end
  
end
