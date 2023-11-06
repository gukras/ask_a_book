RailsAdmin.config do |config|
  config.asset_source = :webpacker
    ## == Devise ==
    config.authenticate_with do
      warden.authenticate! scope: :user
    end

    config.current_user_method(&:current_user)  
end
  