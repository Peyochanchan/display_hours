# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Shop < ApplicationRecord
  has_many :opening_days, dependent: :destroy
  validates :name, presence: true

  accepts_nested_attributes_for :opening_days
end
