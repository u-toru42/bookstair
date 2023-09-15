require 'google/cloud/language'

# Configure Google Cloud Language
Google::Cloud::Language.configure do |config|
  config.credentials = Rails.application.credentials.google_cloud_language[:api_json]
end
