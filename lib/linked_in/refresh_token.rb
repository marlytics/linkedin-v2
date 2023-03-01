module LinkedIn
  # Refresh Token API
  # @see https://learn.microsoft.com/en-us/linkedin/shared/authentication/programmatic-refresh-tokens
  class RefreshToken < APIResource

    def refresh_token(options = {})
      path = 'oauth/v2/accessToken'
      post(path, options, 'Content-Type' => 'application/x-www-form-urlencoded')
    end

  end
end
