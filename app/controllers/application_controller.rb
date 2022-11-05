class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  
  def set_search
    @item_active = Item.where(is_active: true)
    @search = @item_active.ransack(params[:q])
    @search_items = @search.result.page(params[:page]).per(8).order(:id)
    @count = @search_items.total_count
    
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @search_items = @genre.items.page(params[:page]).per(8)
      @count = @search_items.total_count
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
    keys: [:last_name, :first_name, :last_name_kana, :first_name_kana,
           :email, :postal_code, :address, :telephone_number, :is_deleted])
  end
end