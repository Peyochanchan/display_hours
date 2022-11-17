# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :opening_day do
    sequence :weekday, Date::DAYNAMES.cycle
    lunch_break { false }
    closed { false }
    opening_time_one { Time.at(0)   }
    closing_time_one { Time.at(0)   }
    opening_time_two { Time.at(0)   }
    closing_time_two { Time.at(0)   }
    shop
  end

  factory :shop do
    sequence(:name) { |n| "Shop #{n} World" }

    factory :shop_with_weekdays do
      transient do
        weekdays { 7 }
      end
      after :create do |shop, evaluator|
        create_list :opening_day, evaluator.weekdays, shop: shop
        # shop.reload
      end
    end
  end
end
