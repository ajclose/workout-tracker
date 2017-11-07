class AddNameToAmraps < ActiveRecord::Migration[5.1]
  def change
    add_column :amraps, :name, :string
  end
end
