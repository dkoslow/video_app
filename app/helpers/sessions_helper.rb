module SessionsHelper

  def sign_in(user)
    auth_token = SecureRandom.urlsafe_base64
    cookies.permanent[:auth_token] = auth_token
    user.update_column(:auth_token, User.encrypt(auth_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:auth_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    auth_token = User.encrypt(cookies[:auth_token])
    @current_user ||= User.find_by(auth_token: auth_token)
  end

  def current_user?(user)
    current_user == user
  end

  def user_is_signed_in
    unless signed_in?
      store_page
      redirect_to signin_url
    end
  end

  def store_page
    session[:target_page] = request.url
  end

  def redirect_to_target_page_or(default)
    redirect_to(session[:target_page] || default)
    session.delete(:target_page)
  end
end
