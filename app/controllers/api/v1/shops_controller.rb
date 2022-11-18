class Api::V1::ShopsController < Api::V1::BaseController
  def index
    @shops = Shop.includes(:opening_days).order(created_at: :desc)
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
