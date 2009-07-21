class AddOrderAndActiveColumn < ActiveRecord::Migration
  def self.up
    add_column :pages, :order, :boolean
    add_column :pages, :active, :boolean
  end

  def self.down
    remove_column :pages, :order
    remove_column :pages, :active
  end
end