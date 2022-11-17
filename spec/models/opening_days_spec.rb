require 'rails_helper'

RSpec.describe OpeningDay, type: :model do
  let(:opening_day) { FactoryBot.create(:opening_day) }
  let(:shop) { FactoryBot.create(:shop_with_weekdays) }

  subject(:opening_day_one) { FactoryBot.create(:opening_day) }

  it { should belong_to(:shop) }
  it { is_expected.to be_an OpeningDay }
  it { is_expected.to be_persisted }

  it "is valid with valid attributes" do
    expect(opening_day).to be_valid
  end

  describe '#weekday' do
    it 'is required' do
      opening_day.weekday = nil
      opening_day.valid?
      expect(opening_day.errors[:weekday].size).to eq(1)
    end

    it 'has a valid weekday name' do
      opening_day.weekday = 'Toto'
      opening_day.valid?
      expect(opening_day.errors[:weekday].size).to eq(1)
    end

    it { should validate_uniqueness_of(:weekday).scoped_to(:shop_id) }
  end

  describe "#Hours Validations" do
    context "Close Before Open" do
      subject { shop.opening_days.first }
      before do
        subject.update(
          weekday: 'lundi',
          opening_time_one: "2017-21-05 12:00:00",
          closing_time_one: "2017-21-05 09:00:00" # error
        )
      end

      it 'doesn\'t pass validations for invalid lunch closing hours' do
        expect(subject).not_to be_valid
      end

      it "raises an error if first end time is lower than first start time" do
        expect(subject.errors[:opening_time_one]).to include("is supposed to be earlier than Closing time one")
      end
    end

    context "Reopening" do
      before do
        subject.update(
          weekday: 'mardi',
          opening_time_one: "08:00:00",
          closing_time_one: "12:00:00",
          lunch_break: true,
          opening_time_two: "11:00:00" # error
        )
      end

      it 'doesn\'t pass validations for invalid re-opening hour' do
        expect(subject).not_to be_valid
      end

      it "raises an error if reopening is lower than lunch break hour" do
        expect(subject.errors[:opening_time_two]).to include("is supposed to be later than Closing time one")
      end
    end

    context "Final Closing before Open" do
      before do
        subject.update(
          weekday: 'lundi',
          opening_time_one: "2017-21-05 09:00:00",
          closing_time_one: "2017-21-05 12:00:00",
          lunch_break: true,
          opening_time_two: "2017-21-05 14:00:00",
          closing_time_two: "2017-21-05 13:00:00" # error
        )
      end

      it 'pass validations for invalid closing hours' do
        expect(subject).not_to be_valid
      end

      it "raises an error if final closing is lower than first start time (except if it is midnight)" do
        expect(subject.errors[:closing_time_two]).to include("is supposed to be later than Opening time two")
      end
    end
  end
end
