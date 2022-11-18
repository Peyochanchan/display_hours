class ClosingLaterValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    return unless value <= record.closing_time_one && record.lunch_break?

    record.errors.add attr, "is supposed to be later than Closing time one"
  end
end
