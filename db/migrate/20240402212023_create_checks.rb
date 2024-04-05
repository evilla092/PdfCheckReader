class CreateChecks < ActiveRecord::Migration[7.0]
  def change
    create_table :checks do |t|
      t.date :check_date, null: false
      t.decimal :check_amount, null: false
      t.integer :infraction_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
