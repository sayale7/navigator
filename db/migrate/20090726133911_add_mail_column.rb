class AddMailColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :mail, :boolean
  end

  def self.down
    remove_column :users, :mail
  end
end
