class AddImagesLockVersion < ActiveRecord::Migration[5.2]
  def up
    add_column :images, :lock_version, :integer
  end

  def down
    remove_column :images, :lock_version
  end
end
