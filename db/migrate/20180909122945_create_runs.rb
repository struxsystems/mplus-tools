class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs do |t|

      t.datetime :start
      t.datetime :expire

      t.integer :instance

      t.text :description

      t.integer :min_raider_io_score
      t.integer :min_item_level

      t.timestamps
    end
  end
end
