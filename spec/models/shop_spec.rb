# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:shop) { FactoryBot.create(:shop_with_weekdays) }

  it { is_expected.to be_a Shop }
  it { should have_many :opening_days }
  it { should accept_nested_attributes_for :opening_days }

  it "is valid with valid attributes" do
    expect(shop).to be_valid
  end

  describe '#name' do
    it 'is required' do
      shop.name = nil
      shop.valid?
      expect(shop.errors[:name].size).to eq(1)
    end
  end
end
