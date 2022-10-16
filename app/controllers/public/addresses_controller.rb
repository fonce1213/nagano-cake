class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      render addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "変更内容が更新されました"
      redirect_to edit_address_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = "配送先が削除されました"
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
