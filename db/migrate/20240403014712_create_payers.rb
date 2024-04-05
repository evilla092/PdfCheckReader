class CreatePayers < ActiveRecord::Migration[7.0]
  def change
    create_table :payers do |t|
      t.decimal :dues_amount
      t.decimal :cope_amount
      t.string :name
      t.decimal :total_wages_earned_pp
      t.decimal :hourly_rate
      t.references :check, null: false, foreign_key: true

      t.timestamps
    end
  end
end
