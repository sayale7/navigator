class SentController < ApplicationController
  
  def index
    @messages = current_user.sent_messages.paginate :per_page => 5, :page => params[:page], :order => "created_at DESC"
  end
  
  def show
    @message = current_user.sent_messages.find(params[:id])
  end
  
  def new
    @message = current_user.sent_messages.build
    get_users
  end
  
  def create
    @message = current_user.sent_messages.build(params[:message])
    if @message.save
      flash[:notice] = "Nachricht geschickt."
      redirect_to :action => "index"
    else
      get_users
      render :action => "new"
    end
  end
  
  private
  
  def get_users
    @users = User.all()
    @namesarray = Array.new
    @idsarray = Array.new
    for user in @users do
      @namesarray.push(user.username+" ")
      @idsarray.push(user.email)
    end
    @namesarray.push("An alle  ")
    @idsarray.push("alle@dasjetzt.at")
    @namesarray.push("An alle außer Joe ")
    @idsarray.push("alleausserjoe@dasjetzt.at")
  end
  
end
