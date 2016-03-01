class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :email,           :null => false
      t.string   :email_for_index, :null => false
      t.string   :crypted_password
      t.string   :salt
      t.string   :remember_me_token,            :default => nil
      t.datetime :remember_me_token_expires_at, :default => nil
      t.string   :name,            :null => false
      t.string   :icon_image,      :null => false
      t.string   :title
      t.text     :description
      t.integer  :right,           :null => false
      t.timestamps                 :null => false
    end
  end
end
