class AddNameToRfts < ActiveRecord::Migration[5.1]
  def change
    add_column :rfts, :name, :string
  end
end
