class Recipient < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  
  def user_name
    user.username if user
  end
  
  def user_name=(username)
    self.user = User.find_by_username(username) unless username.blank?
  end
end
