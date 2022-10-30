class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    #@order_item = OrderItem.new
  end
  
  def confirm
    #@order_item = OrderItem.new
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @postage = 800
    #@address = Address.find(params[:order][:address_id])
    
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
    #@order_item = OrderItem.new(order_item_params)
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
    cart_items.destroy_all
  end

  def index
    @orders = Order.all
    @order_items = OrderItem.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.all
    @postage = 800
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :payment, :address, :postal_code, :name, :postage, :total_price)
  end

  #def order_item_params
  #  params.require(:order_item).permit(item_id:[], price:[], amount:[])
  #end

end
