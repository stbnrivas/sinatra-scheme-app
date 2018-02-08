# sinatra-scheme

simple schema for new app using sinatra for my own projects

	## requirement

	the proyect use the below gems:

	-sinatra
	-sinatra
	-sinatra-contrib
	-sinatra-r18n
	-sinatra-static-assets
	-multi_json
	-builder
	-sequel
	-sqlite3

	and optional gem are between comments on the code

	-pony

	## include as git submodule

	font-awesome at folder /public/font-awesome
	$ git submodule add https://github.com/FortAwesome/Font-Awesome public/font-awesome

	bootstrap at folder /public/twbs
	git submodule add https://github.com/twbs/bootstrap public/twbs

	when you need update all submodule try with:
	$ git submodule foreach git pull origin


	## Sinatra Classic style

	this repo choose classic ergo don't use subclassing wrapper, if you want choose modular with subclassing Sinatra::Base or Sinatra::Application you will sorround with class and change config.ru check [here](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style)


	## features included

	-schema for sitemap creation
	-minification by [Google html compressor](https://code.google.com/archive/p/htmlcompressor/)
	-customizable bootstrap 4 css inclusion, check


	## future features to include or include at another branches

	-cookies support
	-test, rspec, cucumber, selenium, capibara
	-markdown support at views

	- CI with travis? rsync ...



	## installation

		### database creation

		bundle install
		cd db

		sequel -m migrations/ sqlite://db.sqlite



		### css bootstrap generation
		sass main.scss main.css --style [nested|expanded|compact|compressed]

		### updating font awesome

		font awesome was add using submodules of git

		cd public/
		git submodule add https://github.com/FortAwesome/Font-Awesome

		and you can update doing

		cd public/Font-Awesome
		git pull


		## environment test | development | explotation

		you can change your environment at:


		## how to deploy

		set Rakefile for automatic deploy

	## customization of security

	into the project there some "TODO" you must search and change for your project, like:
	-cookies secret security
	-your domain name for sitemap.xml

	remove git remove references

	git remote -v
	git remote rm destination
	git remote -v

	## for database it use sequel

	## setting configuration for automatic deploy with rake

	check Rakefile and spice the file with
