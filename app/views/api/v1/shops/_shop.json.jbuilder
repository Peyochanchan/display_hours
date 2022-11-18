json.opening_days opening_days.order(id: :asc) do |day|
  json.weekday day.weekday
  json.closed day.closed
  if !day.closed
    json.extract! day, :closed, :lunch_break, :opening_time_one, :closing_time_one
    if day.lunch_break?
      json.reopening day.opening_time_two
      json.final_closing day.closing_time_two
    end

    json.set! day.weekday.downcase do
      json.extract! day, :closed, :lunch_break

      json.starting_time l day.opening_time_one, format: :default
      json.closing_time l day.closing_time_one, format: :default
      if day.lunch_break?
        json.reopening l day.opening_time_two, format: :default, locale: locale
        json.final_closing l day.closing_time_two, format: :default, locale: locale
      end
    end
  end
end
