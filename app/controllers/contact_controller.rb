class ContactController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.contact_message(@message).deliver
      if signed_in_as_parent?
        flash[:success] = "Message was successfully sent."
        redirect_to parent_dash_path
      elsif signed_in_as_child?
        flash[:success] = "Message was successfully sent."
        redirect_to child_dash_path
      else
        flash[:success] = "Message was successfully sent."
        redirect_to root_path
      end
    
    else
      flash[:error] = "Please fill all fields."
      render :new
    end
  end
end
