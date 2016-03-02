class ChangeUserColumn2 < ActiveRecord::Migration
  def change
    change_column :users, :icon_image, :string, null: true
  end
end
