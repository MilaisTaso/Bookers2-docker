class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :devise_permitted_parameters, if: :devise_controller?

  protected

  def form_instance
    @book = Book.new
  end

  def table_head_book
      @start_column = ''
      @center_column = 'title'
      @end_column = 'option'
  end

  def table_head_user
      @start_column = 'image'
      @center_column = 'name'
      @end_column = ''
  end

  private

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def devise_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
  end
end
