class CreateRftmovements < ActiveRecord::Migration[5.1]
  def change
    create_table :rftmovements do |t|
      t.references :rft, foreign_key: true
      t.string :rx_movement
      t.integer :rx_reps
      t.integer :rx_weight
      t.string :rx_unit
      t.string :scaled_movement
      t.integer :scaled_reps
      t.integer :scaled_weight
      t.string :scaled_unit

      t.timestamps
    end
  end
end
