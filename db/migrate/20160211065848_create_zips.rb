class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|
      t.integer  :code, :null => false
      t.timestamps :null => false
    end
  end
end
