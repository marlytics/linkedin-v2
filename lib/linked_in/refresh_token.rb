module LinkedIn
  # Refresh Token API
  # @see https://learn.microsoft.com/en-us/linkedin/shared/authentication/programmatic-refresh-tokens
  class RefreshToken < APIResource

    def refresh_token(options = {})
      # TODO: change url here
      path = "/accessToken"
      get(path, options)
    end

  end
end
