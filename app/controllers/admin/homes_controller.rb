class Admin::HomesController < ApplicationController
   before_action :authenticate_admin!
  
  def top
    @orders = Order.all.page(params[:page])
    @order_items = OrderItem.all
    #@order_item = OrderItem.find(params)
   # @order_items = OrderItem.where(order_id: @order_item.order_id)
  end
  
  private
  def total_amount
    @total_amount = order_item.amount
  end
end