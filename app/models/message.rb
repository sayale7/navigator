class Message < ActiveRecord::Base
  acts_as_authorization_object
  
  validates_presence_of :subject, :message => "(Betreff) Darf nicht leer sein"
  validates_presence_of :to, :message => "(Empfänger) Darf nicht leer sein"
  
  belongs_to :author, :class_name => "User"
  has_many :message_copies
  has_many :recipients
  before_create :prepare_copies, :prepare_recipients
  
  attr_accessor  :to # array of people to send to
  attr_accessible :subject, :body, :to
  
 
  
  def prepare_copies
    @emails = to.uniq
    @emails.each do |touser|
      @users = User.all(:conditions => ["email = '#{touser}'"])
      @users.each do |user|
        message_copies.build(:recipient_id => user.id, :folder_id => 1)
      end
    end
  end
  
  def prepare_recipients
    @emails = to.uniq
    @emails.each do |touser|
      @users = User.all(:conditions => ["email = '#{touser}'"])
      @users.each do |user|
        recipients.build(:user_id => user.id);
      end
    end
  end
end
