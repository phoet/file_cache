require 'tmpdir'

# = FileHelper
# 
# Simple helper for some shared stuff.
#
class FileHelper

  class << self

    # checks if given +file+ already exists or if it expires the +caching_time_in_minutes+
    def not_cached_or_to_old?(file, caching_time_in_minutes)
      File.exists?(file) and (File.mtime(file) + caching_time_in_minutes * 60) > Time.new
    end

    # gets the name of the file-cache for given +token+ and +file_cache_dir+
    def file_cache_name(file_cache_dir, token)
      name = "#{token}".gsub(/[^\w]/, '_')
      "#{file_cache_dir}/#{name}.#{extension}"
    end
    
    # gets the +extension+ of the file-cache
    def extension
      "fc"
    end

    # gets the +tmpdir+ on the current machine
    def tmpdir
      Dir.tmpdir
    end

  end

end