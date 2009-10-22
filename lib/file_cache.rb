require 'file_helper'

# = FileCache
#
# FileCache is a simple utility to persist arbitrary data into a file.
# Just wrap the action you want to cache into a FileCache call and it will be available for 30 minutes by default.
#
# FileCache uses the default tmp-directory of your OS, but you may override that setting via +file_cache_dir+
#
# == Example
#
#   require 'file_cache'
#   include FileCache
#
#   file_cache :cache_token_name do
#     #some_stuff_that_should_be_cached_executed_here
#   end
#
module FileCache

  # configures the directory where file_cache persists the payload
  attr_accessor :file_cache_dir

  # performs the caching with the name of +token+ for the given +payload+ block
  #
  # the +caching_time_in_minutes+ defaults to half an hour
  def file_cache(token, caching_time_in_minutes=30, &payload)
    file = file_name token
    if FileHelper::not_cached_or_to_old? file, caching_time_in_minutes
      load_from_file_cache file
    else
      write_to_file_cache file, (yield payload)
    end
  end

  protected

  # writes given +payload+ to given +file+
  def write_to_file_cache(file, payload)
    puts "direct access, storing in #{file}"
    File.open( file, 'w' ) do |out|
      Marshal.dump(payload, out)
    end
    payload
  end

  # loads payload from given +file+
  def load_from_file_cache(file)
    puts "loading stuff from #{file}"
    File.open(file, 'r') do |input|
      Marshal.load(input.read)
    end
  end

  # gets the name of the file to cache for given +token+
  def file_name(token)
    FileHelper::file_cache_name(file_cache_dir, token)
  end

  # gets the dir where to put the file-caches
  # defaults to _tmpdir_
  def file_cache_dir
    @file_cache_dir || FileHelper::tmpdir
  end

end