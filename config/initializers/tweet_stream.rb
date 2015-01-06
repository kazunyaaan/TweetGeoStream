key = JSON.parse(File.read('config/key.json'))

TweetStream.configure do |config|
  config.consumer_key       = key["consumer_key"]
  config.consumer_secret    = key["consumer_secret"]
  config.oauth_token        = key["oauth_token"]
  config.oauth_token_secret = key["oauth_token_secret"]
  config.auth_method        = :oauth
end
