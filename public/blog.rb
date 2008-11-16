#!/usr/bin/env ruby

begin
  if Camping.respond_to?(:call) # Camping 2
    require 'camping/ar/session'
  else
    require 'camping/session'
  end
end
  
Camping.goes :Blog

$:.unshift File.dirname(__FILE__)
require 'blog/models'
require 'blog/views'
require 'blog/controllers'

Blog::Models.schema do
    create_table :blog_posts, :force => true do |t|
      t.column :id,       :integer, :null => false
      t.column :user_id,  :integer, :null => false
      t.column :title,    :string,  :limit => 255
      t.column :body,     :text
    end
    create_table :blog_users, :force => true do |t|
      t.column :id,       :integer, :null => false
      t.column :username, :string
      t.column :password, :string
    end
    create_table :blog_comments, :force => true do |t|
      t.column :id,       :integer, :null => false
      t.column :post_id,  :integer, :null => false
      t.column :username, :string
      t.column :body,     :text
    end
    execute "INSERT INTO blog_users (username, password) VALUES ('admin', 'camping')"
end
 
def Blog.create
    unless Blog::Models::Post.table_exists?
        ActiveRecord::Schema.define(&Blog::Models.schema)
    end
end

if __FILE__ == $0
  require 'mongrel/camping'

  Blog::Models::Base.establish_connection :adapter => 'sqlite3', :database => 'blog.db'
  Blog::Models::Base.logger = Logger.new('camping.log')
  Blog::Models::Base.threaded_connections=false
  Blog.create

  server = Mongrel::Camping::start("0.0.0.0",3002,"/blog",Blog)
  puts "** Blog example is running at http://localhost:3002/blog"
  puts "** Default username is `admin', password is `camping'"
  server.run.join
end
