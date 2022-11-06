class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @items = Item.where(is_active: "true").order(id: :DESC).limit(4)
    #@items = Item.order(id: :DESC).limit(4)
  end

end
