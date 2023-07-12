require 'open-uri'

module LinkedIn
  #  Images API
  # @see https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/images-api
  class Images < APIResource
    #  Initializing the upload
    #  @see https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/images-api?view=li-lms-2023-05&tabs=http#initialize-image-upload
    #  @options options [String] :owner, the urn of the owner of the image
    def upload_url(options = {})
      path = "rest/images?action=initializeUpload"
      response = post(path, params(options))
      body = JSON.parse(response.body)
      value = body["value"]
      { url: value['uploadUrl'], urn: value['image'] }
    end

    #  Uploading the Image
    #  Note: `Content-Type` header although not mentioned in the docs is required, the upload fails with 400 without it.
    #  @see https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/vector-asset-api?view=li-lms-2023-05&tabs=http#upload-the-image
    #  @options options [String] :owner, the urn of the owner of the image
    def upload_image(image, options)
      response = upload_url(options)
      body = file(image)
      @connection.put(response[:url], body) do |req|
        req.headers['Content-Type'] = 'multipart/form-data'
      end

      response[:urn]
    end

    private

    def params(options)
      MultiJson.dump({ initializeUploadRequest: options })
    end

    def file(source_url)
      URI.parse(source_url).open { |f| f.read }
    end
  end
end
