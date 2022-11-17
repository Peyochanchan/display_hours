class CreateOpeningDays < ActiveRecord::Migration[7.0]
  def change
    create_table :opening_days do |t|
      t.boolean :closed, default: false, null: false
      t.time :opening_time_one
      t.time :closing_time_one
      t.time :opening_time_two
      t.time :closing_time_two
      t.boolean :lunch_break, default: false, null: false
      t.string :weekday, null: false
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
