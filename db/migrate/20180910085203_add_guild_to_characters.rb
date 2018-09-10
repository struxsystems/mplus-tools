class AddGuildToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :guild, :string
  end
end
