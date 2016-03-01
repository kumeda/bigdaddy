class AddIndex < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :users, :remember_me_token

    add_index :spots, :name
    add_index :spots, :yelp_business_id

    add_index :cities, :name

    add_index :states, :name
    add_index :states, :two_digit_code

    add_index :counties, :name

    add_index :zips, :code
  end
end
