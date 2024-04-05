class CreateEmployers < ActiveRecord::Migration[7.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.decimal :dues_rate, precision: 5, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
