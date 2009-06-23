class Message < ActiveRecord::Base
  
  acts_as_authorization_object
  
  belongs_to :author, :class_name => "User"
  has_many :message_copies
  has_many :recipients, :through => :message_copies
  before_create :prepare_copies
  
  attr_accessor  :to # array of people to send to
  attr_accessible :subject, :body, :to
  
  def prepare_copies
      to.each do |recipient|
        recipient = User.find(recipient)
        message_copies.build(:recipient_id => recipient.id, :folder_id => recipient.inbox.id)
      end
  end
end
