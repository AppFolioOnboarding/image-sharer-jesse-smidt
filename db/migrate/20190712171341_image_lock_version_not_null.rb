class ImageLockVersionNotNull < ActiveRecord::Migration[5.2]
  def up
    Image.where(lock_version: nil).delete_all
    change_column :images, :lock_version, :integer, null: false
  end

  def down
    change_column :images, :lock_version, :integer, null: true
  end
end
