class AddNotesToStrengths < ActiveRecord::Migration[5.1]
  def change
    add_column :strengths, :notes, :text
  end
end
