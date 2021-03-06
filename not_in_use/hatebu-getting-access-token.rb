require 'oauth'

SITE_URI          = 'https://www.hatena.com'
REQUEST_TOKEN_URI = '/oauth/initiate?scope=read_public%2Cwrite_public'
ACCESS_TOKEN_URI  = '/oauth/token'

consumer = OAuth::Consumer.new('PUT CONSUMER_KEY',
                               'PUT CONSUMER_SECRET',
                               site: SITE_URI,
                               request_token_url: REQUEST_TOKEN_URI,
                               access_token_url: ACCESS_TOKEN_URI,
                               oauth_callback: 'oob')
request_token = consumer.get_request_token
puts "Visit this website and get the PIN: #{request_token.authorize_url}"

consumer.options.delete(:oauth_callback)
access_token = request_token.get_access_token(oauth_verifier: 'PUT OAUTH VERIFIER')
puts "Access token: #{access_token.token}"
puts "Access token secret: #{access_token.secret}"
