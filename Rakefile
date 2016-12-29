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

desc "Default task if no one is given"
task :default => :build
