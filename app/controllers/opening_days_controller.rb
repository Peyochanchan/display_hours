class OpeningDaysController < ApplicationController
  before_action :set_params, only: %i[edit update]

  def edit; end

  def update
    @opening_day = OpeningDay.find(params[:id])
    if @opening_day.update(days_params)
      redirect_after_update(@shop, @opening_day)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def redirect_after_update(shop, day)
    if @shop.opening_day_ids.max == @opening_day.id
      redirect_to shops_path
    else
      redirect_to edit_shop_opening_day_path(shop, day.id + 1)
    end
  end

  def set_params
    @opening_day = OpeningDay.find(params[:id])
    @shop = Shop.find(params[:shop_id])
  end

  def days_params
    params.require(:opening_day).permit(:shop_id,
                                        :lunch_break,
                                        :closed,
                                        :weekday,
                                        :opening_time_one,
                                        :closing_time_one,
                                        :opening_time_two,
                                        :closing_time_two)
  end
end
