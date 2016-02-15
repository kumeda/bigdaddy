class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login_id, :null => false
      t.string :password, :null => false
      t.string :name, :null => false
      t.string :icon_image, :null => false
      t.string :description, :null => false
      t.timestamps null: false
    end
  end
end
