class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    form_instance
    table_head_book
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @today_book = @books.created_today
    @yesterday_book = @books.created_days_ago(1)
    @week_books = @this_week_book.group('date(created_at)').count
    @day_conparison = @today_book.post_conparison(@yesterday_book)
    @week_conparison = @this_week_book.post_conparison(@last_week_book)
  end

  def index
    @users = User.all
    @table_title = "Users"
    form_instance
    table_head_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
    @table_title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    @book = Book.new
    table_head_user
    render 'show_follow'
  end

  def followers
    @table_title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    @book = Book.new
    table_head_user
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end


end
