Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, Rails.application.secrets.instagram_client_id, Rails.application.secrets.instagram_client_secret, { provider_ignores_state: true }
end