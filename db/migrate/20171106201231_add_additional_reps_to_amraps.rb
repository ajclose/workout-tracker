class AddAdditionalRepsToAmraps < ActiveRecord::Migration[5.1]
  def change
    add_column :amraps, :additional_reps, :integer
  end
end
