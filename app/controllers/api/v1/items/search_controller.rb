class Api::V1::Items::SearchController < ApplicationController
  def show
    @items = search_params
    render json: ItemSerializer.new(@items.first)
  end

  def index
    @items = search_params.order(:name)
    render json: ItemSerializer.new(@items)
  end

  private

  def search_params
    @items = Item.where(nil)
    @items = Item.find_by_name(params[:name]) if params[:name].present?
    @items = @items.find_by_description(params[:description]) if params[:description].present? 
    @items = @items.find_by_unit_price(params[:unit_price]) if params[:unit_price].present? 
    @items = @items.find_by_created(params[:created_at]) if params[:created_at].present?
    @items = @items.find_by_updated(params[:updated_at]) if params[:updated_at].present?
    @items
  end
end
