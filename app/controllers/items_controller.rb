# Controller for items (goods)
class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def create
    @item = Item.new(item_params)
    params[:item][:tags].each do |tag_id|
      if tag_id.to_i != 0
        @item.tags << Tag.find(tag_id.to_i)
      end
    end

    @item.save
    redirect_to @item
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :tags)
  end
end
