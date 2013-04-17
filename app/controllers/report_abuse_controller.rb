class ReportAbuseController < ApplicationController
  def new
    @message = Message.new(params[:message])
  end

  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      NotificationsMailer.report_abuse_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end
