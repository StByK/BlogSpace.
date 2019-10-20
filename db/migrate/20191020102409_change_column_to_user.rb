class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def up
    change_column :images, :image, :string, null: true
  end

  def down
    change_column :images, :image, :string, null: false
  end
end
