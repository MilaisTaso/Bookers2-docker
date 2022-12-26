class SearchesController < ApplicationController
  def search
    search_table
  end

  def search_table
    if !params[:keyword].blank?
      books = Book.book_find_recode(params[:keyword])
      users = User.user_find_recode(params[:keyword])
      book_comments = BookComment.comment_find_recode(params[:keyword])
      books.present? && @books = books
      users.present? && @users = users
      book_comments.present? && @book_comments = book_comments
      if books.blank? && users.blank? && book_comments.blank?
        @result = '該当するデータはありません'
      end
      render 'index'
    else
      flash[:notice] = 'キーワードを入力してください'
      redirect_to request.referer
    end
  end
end
