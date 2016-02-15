class AddReference2 < ActiveRecord::Migration
  def change
    add_reference :users, :city, index: true
  end
end
