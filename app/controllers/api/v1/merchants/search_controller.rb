class Api::V1::Merchants::SearchController < ApplicationController
  def show
    @merchants = search_params
    render json: MerchantSerializer.new(@merchants.first)
  end

  def index
    @merchants = search_params.order(:name)
    render json: MerchantSerializer.new(@merchants)
  end

  private

  def search_params
    @merchants = Merchant.where(nil)
    @merchants = Merchant.find_by_name(params[:name]) if params[:name].present?
    @merchants = @merchants.find_by_created(params[:created_at]) if params[:created_at].present?
    @merchants = @merchants.find_by_updated(params[:updated_at]) if params[:updated_at].present?
    @merchants
  end
end
