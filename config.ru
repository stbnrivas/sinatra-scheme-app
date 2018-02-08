require ::File.join( ::File.dirname(__FILE__), 'app' )

set :environment, :development
#set :environment, :test
#set :environment, :production

disable :run

run Sinatra::Application
#run SinatraApp.new # if use a class