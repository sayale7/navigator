class MessagesController < ApplicationController
  def show
    @message = current_user.received_messages.find(params[:id])
  end
end