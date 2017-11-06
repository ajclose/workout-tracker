class AddNotesToRfts < ActiveRecord::Migration[5.1]
  def change
    add_column :rfts, :notes, :text
  end
end
