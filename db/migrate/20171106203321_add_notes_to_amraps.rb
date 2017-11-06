class AddNotesToAmraps < ActiveRecord::Migration[5.1]
  def change
    add_column :amraps, :notes, :text
  end
end
