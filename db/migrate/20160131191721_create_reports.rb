class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :image, :null => false
      t.timestamps null: false
    end
  end
end
