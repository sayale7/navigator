class MailboxController < ApplicationController
  
  def index
    show
  end
  
  def show
    get_messages('Inbox')
    render :action => "show"
  end
  
  def trash
    get_messages('Trash')
  end
  
  private
  def get_messages(folder)
    @folder = Folder.find_by_user_id_and_name(current_user.id, folder);
    @messages = @folder.messages.all.paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
  end
  
end