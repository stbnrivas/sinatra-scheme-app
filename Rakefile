#rake -w to show commands availables 

namespace :install do

	desc "check gem installation, database is create, customizing of some files has done"
	task :check do
		# check using bundler
		bundler_output = `bundler check`
		puts bundler_output

		# database sqlite creation
		full_path_folder = File.expand_path(".")
		puts "#{full_path_folder}/db/db.sqlite"
		unless File.exist?("#{full_path_folder}/db/db.sqlite")
			puts "database file dont exist, executing: sequel -m db/migrations/ sqlite://db.sqlite"
			`sequel -m db/migrations sqlite://db.sqlite`
			`mv db.sqlite db/`
		else 
			puts "database already exist"
		end

		# - name of file app.rb must be changed 
		# - line config.ru require
		# require ::File.join( ::File.dirname(__FILE__), 'app' )

	end

end



namespace :development do

	desc "create files minified at views, and css minified"
	task :regenerate do
    sh 'cd public/css'
    sh 'sass main.sccs main.css --style expanded'
    sh 'cd ../..'
	end

end



namespace :deploy do 

#  namespace :name_of_project do

	desc "deploy the project at production"
    task :production do

      # uncomment line at file at app.rb
      # set :views, Proc.new { File.join(root, "views-minified") }
      # sh ...
      # TO DO
      # app = File.read(file_name)
      # replace = text.gsub(/Value\=\d+/, "Value=#{newNum}")
      # File.open(filepath, "w") {|file| file.puts replace}

      sh 'cd public/css'
      sh 'sass main.sccs main.css --style compressed'
      sh 'cd ../..'

      # create minification for the views 
      views = Dir.entries "./views/"
      views.delete_if {|f| [".", "..", ".DS_Store","Thumbs.db"].index(f) != nil or File.directory?(f) }
      input_folder = "views"
      output_folder = "views-minified"
  	  views.each do |view|
  	  	if view.to_s.end_with?(".erb")
        		`java -jar htmlcompressor-1.5.3.jar --type html -o ./#{output_folder}/#{view} ./#{input_folder}/#{view}`
    		end
      end
      puts "#{views.length} generated at views-minified"


      # rsync       
      # sh '$full-local-path = pwd'
      # to test full paths and url use this with -n / --dry-run params
      # using .gitignore into rsync --filter=':- .gitignore'
      # sh 'rsync -avvn --rsh "ssh -p portNumber"  --delete $full-local-path@remote-server-url:full-server-path' --filter=':- .gitignore'
      
      # when you are fully sure, uncomment
      #
      # sh 'rsync -avv --rsh "ssh -p portNumber" --delete $full-local-path@remote-server-url:full-server-path' --filter=':- .gitignore'

      # 

      # comment again line at file at app.rb
      # set :views, Proc.new { File.join(root, "views-minified") }
      # sh ...
    end  


# end 

end