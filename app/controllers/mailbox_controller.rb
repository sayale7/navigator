class MailboxController < ApplicationController
  
  def index
    show
  end
  
  def show
    debugger
    @folders = Folder.all(:conditions => ["user_id = #{current_user.id} and name = 'Inbox'"])
    @folder = Folder.find(@folders[0].id)
    @messages = @folder.messages.all(:conditions => ["deleted = false and recipient_id = #{current_user.id}"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @johann = "johann"
    render :action => "show"
  end
  
  def trash
    @folders = Folder.all(:conditions => ["user_id = #{current_user.id} and name = 'Trash'"])
    @folder = Folder.find(@folders[0].id)
    @messages = @folder.messages.all(:conditions => ["deleted = true and recipient_id = #{current_user.id}"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
  end
  
end