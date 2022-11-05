class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @postage = 800
    @address = Address.find(params[:order][:address_id])
    
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
    end
  end
  
  def create
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.save
    
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item.item_id
      order_item.order_id = @order.id
      order_item.price = cart_item.item.with_tax_price
      order_item.amount = cart_item.amount
      order_item.save
    end
    redirect_to complete_orders_path
    current_customer.cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders.all
    #@order_items = OrderItem.all
    #@order_items = OrderItem.where(order_id: order.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @postage = 800
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :payment, :address, :postal_code, :name, :postage, :total_price)
  end

  before_action :authenticate_customer!

end
