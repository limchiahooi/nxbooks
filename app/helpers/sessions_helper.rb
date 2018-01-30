module SessionsHelper

 def current_user
    if session[:user_id]
      # @current_user ||= User.find_by_id(session[:user_id])
      if @current_user == nil
        @current_user = User.find(session[:user_id])
      else
        @current_user
      end
    end
  end

  # Returns true if current_user exists, false otherwise
  def signed_in?
    !current_user.nil?
  end
  
  # a convenient method to set the session to given user's id with the `:user_id` key
  def sign_in(user)
    session[:user_id] = user.id
  end

  # clears the session by setting the value of `:user_id` key to `nil`
  def sign_out
    session[:user_id] = nil
  end

end
