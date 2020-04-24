Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['# 1037372862466-rvnramop6rfku471m76aqfckhumonipf.apps.googleusercontent.com'], ENV['sxMZZIfwloLbVsKqODLu0Kls']
end

# client id - 
# 1037372862466-rvnramop6rfku471m76aqfckhumonipf.apps.googleusercontent.com
# client secret - 
# sxMZZIfwloLbVsKqODLu0Kls