require 'spec_helper'

describe LinkedIn::Images do
  let(:access_token) { 'dummy_access_token' }
  let(:api) { LinkedIn::API.new(access_token) }
  let(:response) do
    {
      value: {
        uploadUrl: 'https://sample-linked-in-upload-url.com',
        image: 'urn:li:image:1212111'
      }
    }
  end
  let(:expected) do
    {
      url: "https://sample-linked-in-upload-url.com",
      urn: "urn:li:image:1212111",
    }
  end

  describe '#upload_url' do
    it 'returns an upload url' do
      stub_request(:post, 'https://api.linkedin.com/rest/images?action=initializeUpload').to_return(body: response.to_json)
      expect(api.upload_url({ 'owner' => 'urn:li:person:121211' }))
        .to eq(expected)
    end
  end

  describe '#upload_image' do
    it 'uploads the image' do
      stub_request(:post, 'https://api.linkedin.com/rest/images?action=initializeUpload').to_return(body: response.to_json)
      stub_request(:put, 'https://sample-linked-in-upload-url.com').with(headers: { 'Content-Type' => 'multipart/form-data' })
      stub_request(:get, 'http://example.org/elvis.png')

      expect(api.upload_image('http://example.org/elvis.png', response))
        .to eq("urn:li:image:1212111")
    end
  end
end
