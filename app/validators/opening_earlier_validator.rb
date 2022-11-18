class OpeningEarlierValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    return unless value > record.closing_time_one && !record.closed?

    record.errors.add attr, "is supposed to be earlier than Closing time one"
  end
end
