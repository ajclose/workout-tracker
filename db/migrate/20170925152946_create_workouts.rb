class CreateWorkouts < ActiveRecord::Migration[5.1]
  def change
    create_table :workouts do |t|
      t.string :date
      t.references :user, foreign_key: true
      t.boolean :tracked, default: false

      t.timestamps
    end
  end
end
