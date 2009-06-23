class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => "Message", :foreign_key => "author_id"
  has_many :received_messages, :class_name => "MessageCopy", :foreign_key => "recipient_id"
  has_many :folders
  
  
  before_create :build_inbox
  
  def inbox
    folders.find_by_name("Inbox")
  end

  def build_inbox
    folders.build(:name => "Inbox")
  end
  
  #authlogic
  acts_as_authentic
  
  #acl9
  acts_as_authorization_subject
end
