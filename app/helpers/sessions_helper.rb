module SessionsHelper
  # needs to be moved elsewhere
  def age_groups
    %w{6-8 8-10 10-12+}
  end
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= (Parent.find_by_remember_token(cookies[:remember_token]) or Child.find_by_remember_token(cookies[:remember_token]))
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def signed_in_as_parent?
    signed_in? and current_user.class == Parent
  end

  def signed_in_as_child?
    signed_in? and current_user.class == Child
  end
end
