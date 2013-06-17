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
    
      Mixpanel.simple_track('Sign in', {'distinct_id' => user.id})
      # Mixpanel.track('Sign in',
      #   {'distinct_id' => user.id} )

      if user.class == Parent
        redirect_back_or parent_dash_path
      else
        redirect_back_or child_dash_path
      end
    else
      redirect_to root_path, flash: { error: 'Invalid email or username/password combination' }
    end
  end

  def destroy
    sign_out 
    redirect_to root_path
  end
end
