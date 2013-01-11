class SessionsController < ApplicationController
  def new
  end

  def create
    user = if params[:session][:email_username] =~ /@/
      Parent.find_by_email(params[:session][:email_username].downcase)
    else
      Child.find_by_username(params[:session][:email_username].downcase)
    end

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email or username/password combination' 
      render 'new'
    end
  end

  def destroy
    sign_out 
    redirect_to root_path
  end
end
