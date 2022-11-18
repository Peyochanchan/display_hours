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

  belongs_to :shop

  validates :weekday, inclusion: { in: Date::DAYNAMES }
  validates_uniqueness_of :weekday, scope: [:shop_id]

  validates :opening_time_one, allow_nil: true, opening_earlier: true
  validates :opening_time_two, allow_nil: true, closing_later: true
  validates :closing_time_two, allow_nil: true, opening_later: true

  private

  ZERO = Time.at(0)

  def reset_useless_hours
    return unless closed?

    self.opening_time_one = ZERO
    self.closing_time_one = ZERO
    self.opening_time_two = ZERO
    self.closing_time_two = ZERO
  end

  def creating_hours
    self.opening_time_one = ZERO.change(hour: 1)
    self.closing_time_one = ZERO.change(hour: 1)
    self.opening_time_two = ZERO.change(hour: 14)
    self.closing_time_two = ZERO.change(hour: 18)
  end
end
