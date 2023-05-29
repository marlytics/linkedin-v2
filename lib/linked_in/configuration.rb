require 'date'

module LinkedIn
  # Configuration for the LinkedIn gem.
  #
  #     LinkedIn.configure do |config|
  #       config.client_id     = ENV["LINKEDIN_CLIENT_ID"]
  #       config.client_secret = ENV["LINKEDIN_CLIENT_SECRET"]
  #     end
  #
  # The default endpoints for LinkedIn are also stored here.
  #
  # LinkedIn uses the term "API key" to refer to "client id". They also
  # use the term "Secret Key" to refer to "client_secret". We alias those
  # terms in the config.
  #
  # * LinkedIn.config.site = "https://www.linkedin.com"
  # * LinkedIn.config.token_url = "/uas/oauth2/accessToken"
  # * LinkedIn.config.authorize_url = "/uas/oauth2/authorization"
  class Configuration
    attr_accessor :api,
                  :site,
                  :scope,
                  :client_id,
                  :token_url,
                  :linkedin_version,
                  :redirect_uri,
                  :authorize_url,
                  :client_secret,
                  :default_profile_fields

    alias_method :api_key, :client_id
    alias_method :secret_key, :client_secret

    def initialize
      @api = "https://api.linkedin.com"
      @linkedin_version = set_linkedin_version
      @site = "https://www.linkedin.com"
      @token_url = "/oauth/v2/accessToken"
      @authorize_url = "/oauth/v2/authorization"
    end

    private

    ## Setting up LinkedIn API version dynamically.
    # Evaluating LinkedIn API version published 45 days before.
    # Keeping buffer of 45 days to not get affected due to any recent changes
    # LinkedIn APIs which might need changes in this gem.
    def set_linkedin_version
      (Date.today - 45).strftime("%Y%m")
    end
  end
end
