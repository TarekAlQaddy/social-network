class AddAttrToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :hometown, :string
    add_column :users, :birthdate, :date
    add_column :users, :marital_status, :string
    add_column :users, :about_me, :text
  end
end
