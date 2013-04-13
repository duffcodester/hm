class ContactController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      if signed_in_as_parent?
        redirect_to(parent_dash_path, :notice => "Message was successfully sent.")
      elsif signed_in_as_child? 
        redirect_to(root_path, :notice => "Message was successfully sent.")
      end
    
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end
