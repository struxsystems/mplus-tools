class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.belongs_to :user

      t.datetime :raider_io_pull

      t.string :name
      t.string :realm
      t.string :region
      
      t.integer :raider_io_score
      t.integer :item_level

      t.boolean :verified

      t.timestamps
    end
  end
end
