$:.unshift File.join(File.dirname(__FILE__),'..','..','lib')

require 'test/unit'
require 'file_cache'

class TestFileCache < Test::Unit::TestCase
  
  include FileCache

  def test_file_cache_name_with_strange_tokens_only_characters_remain
    self.file_cache_dir = 'tmp'
    assert_equal('tmp/a_b_c.mrs', file_cache_name(:'a+b*c'), 'Expected token to be just charactes and underscores!')
  end
  
  def test_file_checking_working
    file = 'timestamp'
    FileUtils.touch file
    assert(not_cached_or_to_old?(file, 1), 'Expected File to be existing and not that old!')
    assert(!not_cached_or_to_old?(file, 0), 'Expected File to be too old!')
    assert(!not_cached_or_to_old?('other', 1), 'Expected File not to exist!')
  end
  
  def test_cache_with_object_tmp_file_is_created
    file = file_cache_name(:name)
    File.delete file if File.exists? file
    payload = [1,2,3]
    result = file_cache :name do payload end
    assert_equal(payload, result, 'Expected result to be same as paylaod!')
    assert(File.exists?(file), 'Expected tmpfile to be created!')
  end
  
end