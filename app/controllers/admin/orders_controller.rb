class Admin::OrdersController < ApplicationController
   before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order_item = OrderItem.new
    @making_not_done = @order_items.where.not(making_status: "done")
    
    unless @order.order_status == "sent"
      if @making_not_done.none?
        @order.order_status = 3
        @order.save
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_items = @order.order_items
    
    if @order.order_status == "payment_confirmation"
      #@order_items = @order.order_items
      @order_items.each do |order_item|
        order_item.making_status = 1
        order_item.save
      end
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
