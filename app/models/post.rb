class Post < ActiveRecord::Base
  acts_as_authorization_object
  
  validates_presence_of :title
  
end
