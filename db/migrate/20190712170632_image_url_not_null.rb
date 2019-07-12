class ImageUrlNotNull < ActiveRecord::Migration[5.2]
  def up
    Image.where(url: nil).delete_all
    change_column :images, :url, :string, null: false
  end

  def down
    change_column :images, :url, :string, null: true
  end
end
