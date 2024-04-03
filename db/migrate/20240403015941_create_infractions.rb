class CreateInfractions < ActiveRecord::Migration[7.0]
  def change
    create_table :infractions do |t|
      t.references :payer, foreign_key: true
      t.string :note
      t.boolean :passed

      t.timestamps
    end
  end
end
