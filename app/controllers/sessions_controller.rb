class SessionsController < ApplicationController
include SessionsHelper

 def create
     @user = User.find_by(email: params[:session][:email]) 

     if @user && @user.try(:authenticate, params[:session][:password]) 
       session[:user_id] = @user.id
       sign_in(@user)
       flash[:success] = "You have successfully signed in!"
       redirect_to root_url
     else
    # If user's login doesn't work, send them back to the login form.
       # flash[:warning] = "Bad email or password."
       # redirect_to sign_in_url

       respond_to do |format|
         format.html { redirect_to sign_in_url }
         format.js 
        end 

     end
  end




  def create_from_omniauth
      auth_hash = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

      # if: previously already logged in with OAuth
      if authentication.user
        user = authentication.user
        authentication.update_token(auth_hash)
        @next = root_url
        flash[:success] = "You have successfully signed in!"
      # else: user logs in with OAuth for the first time
      else
        user = User.create_with_auth_and_hash(authentication, auth_hash)
        # you are expected to have a path that leads to a page for editing user details
        @next = root_url
        flash[:success] = "Welcome to Nvbooks!"
        
      end

      sign_in(user)
      redirect_to @next, :notice => @notice
    end






    def destroy
	    if signed_in?
	      session[:user_id] = nil
	      flash[:info] = "You have successfully signed out."
	      redirect_to root_url
	    end 
  end












end
