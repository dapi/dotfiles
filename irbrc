#require 'rubygems'
#require 'wirble'
#Wirble.init
#Wirble.colorize


# https://github.com/carlhuda/bundler/issues/183#issuecomment-1149953
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].to_s.split(':').grep(/ruby.*@global/).first
  if global_gemset
    all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
    all_global_gem_paths.each do |p|
      gem_path = "#{p}/lib"
      $LOAD_PATH << gem_path
    end
  end
end
# Use Pry everywhere
require "rubygems"
begin
  require "pry"
  #Pry.start
  #exit
rescue LoadError => e
  # warn "=> Unable to load pry"
end
