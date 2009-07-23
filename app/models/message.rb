class Message < ActiveRecord::Base
  
  validates_presence_of :to, :message => "(Empfänger) Darf nicht leer sein"
  
  belongs_to :author, :class_name => "User"
  
  has_many :message_copies
  has_many :recipients
  
  before_create :prepare_copies, :prepare_recipients
  
  attr_accessor  :to # array of people to send to
  attr_accessible :subject, :body, :to
  
  
  def prepare_copies
    get_users_from_collection(to)
    @emails.each do |touser|
      get_users(touser)
      @users.each do |user|
        @folder = Folder.find_by_user_id_and_name("#{user.id}", 'Inbox');
        message_copies.build(:recipient_id => user.id, :folder_id => @folder.id)
      end
    end
  end
  
  def prepare_recipients
    @emails.each do |touser|
      get_users(touser)
      @users.each do |user|
        recipients.build(:user_id => user.id);
      end
    end
  end
  
  private
  def get_users(touser)
    @users = User.find_all_by_email(touser)
  end
  
  def get_users_from_collection(tousers)
    debugger
    @emails = Array.new
    if tousers.include?("alle@dasjetzt.at") && !tousers.include?("alleausserjoe@dasjetzt.at")
      users = User.all
      users.each do |user|
        @emails.push(user.email)
      end
    end
    @emails = Array.new
    if tousers.include?("alle@dasjetzt.at") && tousers.include?("alleausserjoe@dasjetzt.at")
      users = User.all
      users.each do |user|
        @emails.push(user.email)
      end
    end
    if !tousers.include?("alle@dasjetzt.at") && tousers.include?("alleausserjoe@dasjetzt.at")
      users = User.all(:conditions => ("username != 'joe'"))
      users.each do |user|
        @emails.push(user.email)
      end
    end
    if !tousers.include?("alle@dasjetzt.at") && !tousers.include?("alleausserjoe@dasjetzt.at")
      @emails = tousers.uniq
    end
  end
end