# -------------------------------------------------------------------------
#	Rakefile to work with Jekyll
#	stringex: Advanced string operations like to_url()
# -------------------------------------------------------------------------
require "rake"
require "rubygems"
require "stringex"

# -------------------------------------------------------------------------
#	Tasks for development process
# -------------------------------------------------------------------------
# Usage: rake build
desc "Build Jekyll site locally"
task :build do
  puts "* Build Jekyll site"
  system "jekyll build --profile"	
end

# Usage: rake serve
desc "Start development server locally"
task :serve do
  puts "* Starting development server"
  system "jekyll serve --trace --incremental"
end

# -------------------------------------------------------------------------
#	Tasks for a new posting (thanks to Octopress)
# -------------------------------------------------------------------------
# Usage: rake new['My new title']
desc "Create a new post in _post"
task :new, [:title] do | t, args |
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post:")
  end
  filename = "_posts/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.md"
  if File.exist?(filename)
    abort("post with title still exists")
  end
  puts "* Creating a new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: #{title}"
    post.puts "date: #{Time.now.strftime('%Y-%m-%d')}"
    post.puts "category: "
    post.puts "tags: [,]"
    post.puts "---"
  end  
end

# Usage: rake status
desc "Get status information from git"
task :status do
  puts "* Calling git status"
  system "git status"
end

# Usage: rake publish
desc "Publish sources to GitHub pages"
task :publish do
  puts "* Preparing publish\n"
  system "git pull"
  system "git add --all"
  message = "site updated at #{Time.now.utc}"
  puts "* Commiting: #{message}\n"
  system "git commit -m \"#{message}\""
  puts "* Pushing to GitHub\n"
  system "git push origin \"master\""
  puts "* Publishing completed" 
end

# -------------------------------------------------------------------------
#	Tasks for sending update requests to Google, Bing and Ping-O-Matic
# -------------------------------------------------------------------------
# Usage: rake notify
task :notify => ["notify:pingomatic", "notify:google", "notify:bing"]
desc "Notify various services that the site has been updated"
namespace :notify do

  desc "Notify Ping-O-Matic"
  task :pingomatic do
    begin
      require 'xmlrpc/client'
      puts "* Notifying Ping-O-Matic that the site has updated"
      XMLRPC::Client.new('rpc.pingomatic.com', '/').call('weblogUpdates.extendedPing', 'kivio.org' , '//kivio.org', '//kivio.org/blog/feed/atom.xml')
    rescue LoadError
      puts "! Could not ping ping-o-matic, because XMLRPC::Client could not be found."
    end
  end

  desc "Notify Google of updated sitemap"
  task :google do
    begin
      require 'net/http'
      require 'uri'
      puts "* Notifying Google that the site has updated"
      Net::HTTP.get('www.google.com', '/webmasters/tools/ping?sitemap=' + URI.escape('//kivio.org/sitemap.xml'))
    rescue LoadError
      puts "! Could not ping Google about our sitemap, because Net::HTTP or URI could not be found."
    end
  end

  desc "Notify Bing of updated sitemap"
  task :bing do
    begin
      require 'net/http'
      require 'uri'
      puts '* Notifying Bing that the site has updated'
      Net::HTTP.get('www.bing.com', '/webmaster/ping.aspx?siteMap=' + URI.escape('//kivio.org/sitemap.xml'))
    rescue LoadError
      puts "! Could not ping Bing about our sitemap, because Net::HTTP or URI could not be found."
    end
  end
end

desc "Update site and notify search engines"
task :update => [:publish, :notify]

desc "Default task if no one is given"
task :default => :build
