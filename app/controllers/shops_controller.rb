class ShopsController < ApplicationController
  before_action :set_params, only: %i[show edit update destroy create_week_days]
  after_action :create_week_days, only: :create

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @links = ['index', 'new']
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to @shop, notice: 'shop was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @shop.update(shop_params)
      redirect_to shops_url, notice: 'shop was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop.destroy
    redirect_to shops_path, notice: 'shop was successfully destroyed.'
  end

  private

  def create_week_days
    @days = Date::DAYNAMES
    @days.each do |d|
      OpeningDay.create!(weekday: d, shop_id: @shop.id)
    end
  end

  def set_params
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name)
  end
end
