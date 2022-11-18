module ApplicationHelper
  #####################################
  # WEEKDAYS ROTATION AND TRANSLATION #
  #####################################
  def today
    Date.today.wday
  end

  def translated(day)
    Date::DAYNAMES.index { |d| d == day.weekday }
  end

  ###########################################
  # DISPLAY TWO / FOUR HOURS / 'NOT EDITED' #
  ###########################################
  def display_hours(day)
    "#{first_opening(day)}#{second_opening(day)}"
  end

  def first_opening(day)
    if not_edited(day)
      t("day.not_edited", locale: locale).to_s
    else
      "#{l day.opening_time_one, format: :default}—#{l day.closing_time_one, format: :default}"
    end
  end

  def second_opening(day)
    if day[:lunch_break]
      ", #{l day.opening_time_two, format: :default}—#{l day.closing_time_two, format: :default}"
    else
      ''.clear
    end
  end

  def not_edited(day)
    zero = ["00:00", "01:00", "00.00 AM", "01.00 AM"]
    zero.include?(day.opening_time_one.to_fs(:time)) && zero.include?(day.closing_time_one.to_fs(:time))
  end

  #########################################
  # LINKS TO NEXT DAY OR PREVIOUS EDITING #
  #########################################
  def previous_day(shop, weekday)
    link_to '<< previous', edit_shop_opening_day_path(shop, weekday.id - 1), class: "btn btn btn-outline-dark px-4 py-2"
  end

  def next_day(shop, weekday)
    link_to 'next >>', edit_shop_opening_day_path(shop, weekday.id + 1), class: "btn btn btn-outline-dark px-4 py-2"
  end
end
