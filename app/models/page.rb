class Page < ActiveRecord::Base
  acts_as_tree
  validates_presence_of :name
  
  define_index do
    indexes content
  end
end
