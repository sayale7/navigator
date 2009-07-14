class MessagesController < ApplicationController
  
  def show
    @message = current_user.received_messages.find(params[:id])
  end
  
  def reply
    @original = current_user.received_messages.find(params[:id])
    
    subject = @original.subject.sub(/^(Re: )?/, "Re: ")
    body = @original.body.gsub(/^/, "> ")
    @message = current_user.sent_messages.build(:to => [@original.author.id], :subject => subject, :body => body)
    get_users
    render :template => "sent/new"
  end
  
  def read
    @message = MessageCopy.find(params[:id])
    @message.update_attribute("read", true)
    show
    render :action => "show"
  end
  
  def html_destroy
    @message = MessageCopy.find(params[:id])
    @message.update_attribute("deleted", true)
    @folders = Folder.all(:conditions => ["user_id = #{current_user.id} and name = 'Trash'"])
    @folder = Folder.find(@folders[0].id)
    @message.update_attribute("folder_id", @folder.id)
    @folder = current_user.trash
    @messages = @folder.messages.all(:conditions => ["deleted = true"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @folder = current_user.inbox
    @messages = @folder.messages.all(:conditions => ["deleted = false"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    
    respond_to do |format|
      format.html { redirect_to(inbox_url) }
      format.xml  { head :ok }
    end
    
  end
  
  def html_undelete
    @message = MessageCopy.find(params[:id])
    @message.update_attribute("deleted", false)
    @folders = Folder.all(:conditions => ["user_id = #{current_user.id} and name = 'Inbox'"])
    @folder = Folder.find(@folders[0].id)
    @message.update_attribute("folder_id", @folder.id)
    @folder = current_user.inbox
    @messages = @folder.messages.all(:conditions => ["deleted = false"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    @folder = current_user.trash
    @messages = @folder.messages.all(:conditions => ["deleted = true"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    
    respond_to do |format|
      format.html { redirect_to(trash_url) }
      format.xml  { head :ok }
    end
    
  end
  
  def destroy
    @message = current_user.received_messages.find(params[:id])
    @message.update_attribute("deleted", true)
    @folders = Folder.all(:conditions => ["user_id = #{current_user.id} and name = 'Trash'"])
    @folder = Folder.find(@folders[0].id)
    @message.update_attribute("folder_id", @folder.id)
    @folder = Folder.find(@folder.id)
    @messages = @folder.messages.all(:conditions => ["deleted = false and recipient_id = #{current_user.id}"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    
    render :update do |page|
      page.replace_html 'inbox', :partial => 'layouts/inbox_list'
      page.replace_html 'mailbox_trash', :partial => 'layouts/trash_container'
    end
  end
  
  def undelete
    @message = current_user.received_messages.find(params[:id])
    @message.update_attribute("deleted", false)
    @folders = Folder.all(:conditions => ["user_id = #{current_user.id} and name = 'Inbox'"])
    @folder = Folder.find(@folders[0].id)
    @message.update_attribute("folder_id", @folder.id)
    @folder = Folder.find(@folder.id)
    @messages = @folder.messages.all(:conditions => ["deleted = true and recipient_id = #{current_user.id}"]).paginate :per_page => 5, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
    
    
    render :update do |page|
      page.replace_html 'inbox', :partial => 'layouts/trash_list'
    end
  end
  
  def delete_complete
    @message = current_user.received_messages.find(params[:id])
    @message.destroy
    
    respond_to do |format|
      format.html { redirect_to(trash_url) }
      format.xml  { head :ok }
    end
  end
  
  def forward
    @original = current_user.received_messages.find(params[:id])
    
    subject = @original.subject.sub(/^(Fwd: )?/, "Fwd: ")
    body = @original.body.gsub(/^/, "> ")
    @message = current_user.sent_messages.build(:subject => subject, :body => body)
    get_users
    render :template => "sent/new"
  end
  
  def reply_all
    @original = current_user.received_messages.find(params[:id])
    
    subject = @original.subject.sub(/^(Re: )?/, "Re: ")
    body = @original.body.gsub(/^/, "> ")
    recipients = @original.recipients.map(&:id) - [current_user.id] + [@original.author.id] 
    @message = current_user.sent_messages.build(:to => recipients, :subject => subject, :body => body)
    get_users
    render :template => "sent/new"
  end
  
  private
  
  def get_users
    @users = User.all()
    @namesarray = Array.new
    @idsarray = Array.new
    for user in @users do
      @namesarray.push(user.firstname + " " + user.lastname)
      @idsarray.push(user.email)
    end
  end
  
end