class AddProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end
end
