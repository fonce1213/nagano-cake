class Admin::OrderItemsController < ApplicationController
   before_action :authenticate_admin!
  
  def update
    @order_item = OrderItem.find(params[:id])
    @order_items = OrderItem.where(order_id: @order_item.order_id)
    #order_item = OrderItem.new
    #@order_item = @order.order_item
    @order_item.update(order_item_params)
    redirect_to admin_order_path(@order_item.order)
  end
  
  private
  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
