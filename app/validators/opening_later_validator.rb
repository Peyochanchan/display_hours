class OpeningLaterValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    return unless value < record.opening_time_two

    record.errors.add attr, "is supposed to be later than Opening time two" if value != Time.zone.parse('Jan 2000')
  end
end
