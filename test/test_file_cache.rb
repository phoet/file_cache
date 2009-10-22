require 'test_helper'

class TestFileCache < Test::Unit::TestCase
  
  include FileCache
  
  def test_cache_with_object_tmp_file_is_created
    file = file_name(:name)
    File.delete file if File.exists? file
    payload = [1,2,3]
    result = file_cache :name do payload end
    assert_equal(payload, result, 'Expected result to be same as paylaod!')
    assert(File.exists?(file), 'Expected tmpfile to be created!')
  end
  
end