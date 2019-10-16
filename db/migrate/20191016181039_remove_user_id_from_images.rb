class RemoveUserIdFromImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :user_id, :refference
  end
end
