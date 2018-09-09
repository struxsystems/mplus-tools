class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :battletag

      t.string :email
      t.string :password
      t.string :access_code

      t.string :phone

      t.boolean :verified

      t.jsonb :settings, null: false, default: {}

      t.timestamps
    end
  end
end
