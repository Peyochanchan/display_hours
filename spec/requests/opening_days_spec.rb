require 'rails_helper'

RSpec.describe "OpeningDays", type: :request do
  let(:shop) { FactoryBot.create(:shop_with_weekdays) }
  let(:opening_day) { FactoryBot.create(:opening_day) }
  let(:today) { Date::DAYNAMES[Date.today.wday] }
  let(:attributes) { { shop_id: shop.id, closed: true, weekday: today } }
  let(:shop_one) { instance_double(Shop) }

  subject { shop.opening_days.first }

  context "#Update" do
    before do
      subject.update(
        closed: true
      )
    end

    it { expect(subject.closed).to be true }
  end
end
