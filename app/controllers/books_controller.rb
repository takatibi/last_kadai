class BooksController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]


   def create
   	@book = Book.new(book_params)
   	@book.user_id = current_user.id

      if @book.save
         flash[:notice] = "You have updated book successfully"
         redirect_to book_path(@book.id)
      else
         @books = Book.all
         render :index
      end
   end

   def index
   	  @books = Book.all
      @book = Book.new
   end

   def edit
      @book = Book.find(params[:id])
   end

   def update
      @book = Book.find(params[:id])
     if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book.id)
     else
      render action: :edit
     end
   end

   def show
   	  @book = Book.find(params[:id])
      @comments = @book.comments.page(params[:page]).reverse_order
      @book_new = Book.new
      @comment = Comment.new
   end

   def destroy
      @books = Book.find(params[:id])
      @books.destroy
      redirect_to books_path
   end

   private
   def book_params
   	params.require(:book).permit(:title, :body, :profile_image)
   end

    def correct_user
    @book = Book.find(params[:id])
    if   current_user != @book.user
      redirect_to books_path
    end
  end

end




























