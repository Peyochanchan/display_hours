module ApplicationHelper
  def today
    Date.today.wday
  end

  def translated(day)
    Date::DAYNAMES.index { |d| d == day.weekday }
  end

  def display_hours(day)
    first_opening_time = "#{day.opening_time_one.to_fs(:time)}—#{day.closing_time_one.to_fs(:time)}"

    first_opening = day.opening_time_one.to_fs(:time) == '00:00' && day.closing_time_one.to_fs(:time) == '00:00' ? '——not edited——' : first_opening_time
    second_opening = day[:lunch_break] ? ", #{day.opening_time_two.to_fs(:time)}—#{day.closing_time_two.to_fs(:time)}" : ''

    first_opening + second_opening
  end

  def previous_day(shop, weekday)
    link_to '<< previous', edit_shop_opening_day_path(shop, weekday.id - 1), class: "btn btn btn-outline-dark px-4 py-2"
  end

  def next_day(shop, weekday)
    link_to 'next >>', edit_shop_opening_day_path(shop, weekday.id + 1), class: "btn btn btn-outline-dark px-4 py-2"
  end
end
