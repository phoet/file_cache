$:.unshift File.join(File.dirname(__FILE__),'..','..','lib')

require 'test/unit'
require 'rails_file_cache'

class TestRailsFileCache < Test::Unit::TestCase

  def test_current_stuff_is_running
    ActiveSupport::Cache::RailsFileCache.new.write('key', 'value')
  end
end