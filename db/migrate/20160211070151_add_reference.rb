class AddReference < ActiveRecord::Migration
  def change
    add_reference :reports, :user, index: true
    add_reference :reports, :spot, index: true

    add_reference :counties, :state, index: true
    add_reference :cities, :county, index: true
    add_reference :zips, :city, index: true
    add_reference :zips, :spot

    add_reference :spots, :city, index: true
  end
end