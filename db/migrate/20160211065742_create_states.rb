class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, :null => false
      t.string :two_digit_code, :null => false
      t.timestamps null: false
    end
  end
end
