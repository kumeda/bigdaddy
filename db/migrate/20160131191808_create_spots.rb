class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name, :null => false
      t.string :yelp_url, :null => false
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.string :display_address, :null => false
      t.integer :yelp_business_id, :null => false

      t.timestamps null: false
    end
  end
end
