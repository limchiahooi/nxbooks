 Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'], 
    	scope: 'email, public_profile, user_friends, user_hometown, user_posts, publish_actions',
    	info_fields: 'name, email'
  end