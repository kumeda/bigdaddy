class AddReference3 < ActiveRecord::Migration
  def change
    add_column :spots, :yelp_image_url, :string
  end
end
