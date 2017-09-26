class CreateAmraps < ActiveRecord::Migration[5.1]
  def change
    create_table :amraps do |t|
      t.references :workout, foreign_key: true
      t.string :time
      t.integer :score

      t.timestamps
    end
  end
end
