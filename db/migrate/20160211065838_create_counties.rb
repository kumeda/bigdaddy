class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name, :null => false
      t.timestamps :null => false
    end
  end
end
