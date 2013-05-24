class ReportAbuseController < ApplicationController
  def new
    @message = Message.new(params[:message])
    @message.email = current_user.email
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.report_abuse_message(@message).deliver
      flash[:success] = "Message was successfully sent."
      redirect_to parent_dash_path
    else
      flash[:error] = "Please fill all fields."
      redirect_to :back
    end
  end

end
