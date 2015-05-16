class AddEpkAndAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :epk, :string
    add_column :users, :address, :string
    add_index :users, :name, :unique => true
  end
end
