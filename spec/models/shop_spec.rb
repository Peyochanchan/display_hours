require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:shop) { FactoryBot.create(:shop) }

  it { is_expected.to be_a Shop }

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
