class RemoveTrackedFromWorkouts < ActiveRecord::Migration[5.1]
  def change
    remove_column :workouts, :tracked, :boolean
  end
end
