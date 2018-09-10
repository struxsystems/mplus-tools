class AddThumbnailUrlToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :thumbnail_url, :string
  end
end
