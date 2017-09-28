class CreateRfts < ActiveRecord::Migration[5.1]
  def change
    create_table :rfts do |t|
      t.references :workout, foreign_key: true
      t.string :score
      t.integer :rounds

      t.timestamps
    end
  end
end
