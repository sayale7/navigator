class RecipientsController < ApplicationController
 
  
  def index
    @users = User.find(:all, :conditions => ['username LIKE ?', "%#{params[:search]}%"])
    respond_to do |format|
        format.js
      end
    
  end
  
  def put
    @user = User.find(params[:username])
     respond_to do |format|
      format.html { redirect_to @user }
      format.xml  { head :ok }
    end
  end
end
