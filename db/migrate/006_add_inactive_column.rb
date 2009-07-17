class AddInactiveColumn < ActiveRecord::Migration
  def self.up
    add_column :pages, :inactive, :boolean
  end

  def self.down
    remove_column :pages, :inactive
  end
end