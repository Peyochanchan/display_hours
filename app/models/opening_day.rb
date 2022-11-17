# == Schema Information
#
# Table name: opening_days
#
#  id               :bigint           not null, primary key
#  closed           :boolean          default(FALSE), not null
#  closing_time_one :time
#  closing_time_two :time
#  lunch_break      :boolean          default(FALSE), not null
#  opening_time_one :time
#  opening_time_two :time
#  weekday          :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shop_id          :bigint           not null
#
# Indexes
#
#  index_opening_days_on_shop_id  (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#
class OpeningDay < ApplicationRecord
  before_update :reset_useless_hours
  before_create :creating_hours

  ZERO = Time.at(0)
  belongs_to :shop
  validates :weekday, inclusion: { in: Date::DAYNAMES }
  validates_uniqueness_of :weekday, scope: [:shop_id]

  validates_each :opening_time_one, allow_nil: true do |record, attr, value|
    if value > record.closing_time_one && !record.closed?
      record.errors.add attr, "is supposed to be earlier than Closing time one"
    end
  end

  validates_each :opening_time_two, allow_nil: true do |record, attr, value|
    if value <= record.closing_time_one && record.lunch_break?
      record.errors.add attr, "is supposed to be later than Closing time one"
    end
  end

  validates_each :closing_time_two, allow_nil: true do |record, attr, value|
    if value < record.opening_time_two
      record.errors.add attr, "is supposed to be later than Opening time two" if value != Time.zone.parse('Jan 2000')
    end
  end

  def reset_useless_hours
    if self.closed?
      self.opening_time_one = ZERO
      self.closing_time_one = ZERO
      self.opening_time_two = ZERO
      self.closing_time_two = ZERO
    end
  end

  def creating_hours
    self.opening_time_one = ZERO.change(hour: 1)
    self.closing_time_one = ZERO.change(hour: 1)
    self.opening_time_two = ZERO.change(hour: 15)
    self.closing_time_two = ZERO.change(hour: 19)
  end
end
