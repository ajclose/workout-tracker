class CreateStrengths < ActiveRecord::Migration[5.1]
  def change
    create_table :strengths do |t|
      t.references :workout, foreign_key: true
      t.string :movement
      t.integer :sets
      t.integer :reps
      t.integer :weight

      t.timestamps
    end
  end
end
