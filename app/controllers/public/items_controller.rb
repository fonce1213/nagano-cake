class Public::ItemsController < ApplicationController
  def index
    #@items = Item.all
    @items = Item.where(is_active: "true")
    @genres = Genre.all
    #OrderItem.where(order_id: order.id)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end


end
