class Changedateinworkouttodate < ActiveRecord::Migration[5.1]
  def change
    change_column :workouts, :date, 'date USING CAST(date AS date)'
  end
end
