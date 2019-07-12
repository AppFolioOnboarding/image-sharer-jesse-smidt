class AddLockVersionDefault < ActiveRecord::Migration[5.2]
  def up
    change_column :images, :lock_version, :integer, null: false, default: 0
  end

  def down
    change_column :images, :lock_version, :integer, null: false
  end
end
