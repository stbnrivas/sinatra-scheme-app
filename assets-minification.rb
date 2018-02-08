#!/usr/bin/ruby


require "parallel" # https://github.com/grosser/parallel




def google_compress_html(input_folder,input_file,output_folder,output_file)
	# example 
	# ./#{input_folder}/#{input_file} ==> ./#{output_folder}/#{output_file} 
	result = ""
	Dir.chdir("./") do
	    # Use your path to the java according to the java directory installed in your machine.
	    # puts "compressing #{input_file}"
	    result = system("/usr/bin/java -jar htmlcompressor-1.5.3.jar --type html -o ./#{output_folder}/#{output_file} ./#{input_folder}/#{input_file}")
	    puts "file  ./#{output_folder}/#{output_file} COMPRESSED"
	end
	result 
end 





######################################################################################
###
### => CSS MINIFIER USING SASS
###

# main.scss include all another scss file, only it need main.scss => main.css

# puts "\n"
# puts "-------------------------\n"
# puts " generating main.css from main.scss\n\n"

# result = system("sass public/css/main.scss:public/css/main.css --style expanded ")
# puts "  generating file main.css #{result}"

# result = system("sass public/css/main.scss:public/css/main.min.css --style compressed ")
# puts "  generating file main.min.css #{result}"






######################################################################################
###
### => HTML MINIFIER WITH GOOGLE HTMLCOMPRESSOR
###

# Loop through items in the dir
files = Dir.entries "./views/"
# clean file list of known non-files
files.delete_if {|f| [".", "..", ".DS_Store"].index(f) != nil or File.directory?(f) }


# let the user know we've begun...
totalFiles = files.length;

# remove old min files
puts "\n\n-------------------------\n"
puts " generating #{totalFiles} *.erb minified\n\n"

input_folder = "views"
output_folder = "views-minified"
# generate new min files
files.each do |file|	
	if file.to_s.end_with?(".erb")	
		google_compress_html(input_folder,file,output_folder,file)
	end
end









=begin
# process the images in parallel threads (up to 4)
i = 1
completed = Parallel.each(files){|file|

  if File.file? file and not file.to_s.end_with? "min.html.twig"
	google_compress_html(file,file.gsub(/html\.twig/,"min.html.twig"))    
    # micro-sleep so other processes can get some CPU time
    sleep 0.3  
  end
}

# Show a growl notification if available.
#system("growlnotify --appIcon Terminal -m 'Finshed resizing images!' Ruby")

puts "Finished compressed #{completed.length} files"
=end
