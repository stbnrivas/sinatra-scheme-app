#encoding: UTF-8



require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/static_assets'
require 'sinatra/r18n'

require 'sequel'
require 'logger'



## for additional features uncomment and add to Gemfile
#require 'pony'
#require 'rmagick'
#require 'fileutils'


configure do  
  # LANGUAGES = ['es','en','fr','de','ru']
end

# TO DO: develop, minify, and uncomment below line
# set :views, Proc.new { File.join(root, "views-minified") }

use Rack::Session::Cookie, :key => 'rack.session', :path => '/', :expire_after => 2592000, :secret => '9234fjasd95ga0e9h03fgks9-dsa439sd'



Sequel::Model.plugin(:schema) 
#DB = Sequel.connect('sqlite://db/discover.sqlite')
DB = Sequel.connect('sqlite://db/db.sqlite',:logger => Logger.new('db.log'))


require './models/model_example.rb'


DEFAULT_LOCALE = 'en'


before do
  #params[:locale] = 'es' if params[:locale].nil?
  #session[:locale] = params[:locale] if params[:locale]
  
  #content_type :html, 'charset' => 'utf-8'
  #redirect request.url.sub(/www\./, ''), 301 if request.host =~ /^www/

  def locale_valid?
    result = false
	LOCALES.each do |loc|
		result = loc == params[:locale] || result
	end
	result
  end
  
  def set_locale
	@locale = DEFAULT_LOCALE unless locale_valid?
  end 

end



helpers do	

	def cookies_message
		result = ''
		# if session[:allowGoogleAnalytics].nil?
		# 	result = "<div class=\"breadcrumb\" id=\"cookies-message\"> <p></a>.</p>  Aceptar. </div>"
		# 	session[:allowGoogleAnalytics] = 'message show'
		# elsif session[:allowGoogleAnalytics] == 'message show'
		# 	session[:allowGoogleAnalytics] = 'allow'
		# end		
		return result
	end

	# def allowGoogleAnalytics?
	# 	return session[:allowGoogleAnalytics] ? true : false ; 
	# end

	def google_analytics_code
		result = ''
		if session[:allowGoogleAnalytics] == 'allow'
			result = "<script type=\"text/javascript\">
		      var _gaq = _gaq || [];
		      _gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
		      _gaq.push(['_trackPageview']);

		      (function() {
		        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		      })();
		    </script>"
  		end
  		result
	end

end



##############################################################################

##############################################################################
###########################         BACKEND           ########################
##############################################################################

##############################################################################

["/es/admin/", "/en/admin"].each do |path|
	get path do 
		if User.authentication_by_remember_token?(session[:token],['admin','photo'])
			@current_user = User.find(:remember_token => session[:token])
			# erb :admin_dashboard, :layout => :layout_backend			
			
			# return "User.authentication_by_remember_token?(session[:token],['admin','photo']) = true" 
			redirect "/admin/dashboard"
		else
			#flash[:notice] = ""
			erb :admin_login, :layout => :layout_login
		end
	end
end




##############################################################################

##############################################################################
###########################         FRONTEND          ########################
##############################################################################

##############################################################################

get '/' do
  redirect "/es/"
end


["/:locale/", "/:locale/"].each do |path|
	get path do
		@html_title = t.pages.index.title
		@current_page = :index

		#example of use model from db		
		@model   = ModelExample.find(:id => 1) || []
		@model_2 = ModelExample.find(:title_es => 'primer articulo') || []


		@models = DB[:model_examples]

		# example of use session
		session[:notice] = "notice message"
		session[:warning] = "notice warning"
		session[:notice] = nil
		session[:warning] = nil
		
		# if want specify another layout file
		# erb :index, :layout => :layout
		erb :index
	end 
end




##############################################################################

##############################################################################
###########################      SITEMAP & 404        ########################
##############################################################################

##############################################################################



["/:locale/sitemap.xml", "/:locale/sitemap.xml"].each do |path|
	get path do
		@pages_es = [ 
			{ :url => "#{params[:locale]}/", :lastmod => '2013-06-15'},	
			{ :url => "#{params[:locale]}/pagina-no-encontrada", :lastmod => '2013-06-15'}
		]
		@pages_en = [ 
			{ :url => "#{params[:locale]}/", :lastmod => '2013-06-15'},	
			{ :url => "#{params[:locale]}/page-not-found", :lastmod => '2013-06-15'}
		]

		@pages = (params[:locale] == 'en' ? @pages_en : @pages_es ;)

		content_type 'xml'		
			
		builder do |xml|
			xml.instruct!
			xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

				xml.url do
					# TODO: change your domain
					xml.loc "http://yourdomain.com/es/"
					xml.priority 1.0
				end

				@pages.each do |p|
					xml.url do
						xml.loc "http://#{request.host}/#{p[:url]}"
						#xml.lastmod Time.parse("#{p[:lastmod]}").utc.strftime("%Y-%m-%d")
						xml.changefreq "monthly"
						xml.priority 0.1
					end
				end
			end
		end
	end
end


		

["/:en/page-not-found", "/:es/pagina-no-encontrada"].each do |path|
	get path do 
		erb :'404'
	end 
end



##############################################################################

##############################################################################
###########################         REST API          ########################
##############################################################################

##############################################################################



get "/api/login" do 
	
end 


get "/api/logout" do 
	
end 
