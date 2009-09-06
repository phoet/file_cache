Gem::Specification.new do |s|
  s.name = 'file_cache'
  s.version = '0.0.1'

  s.author = 'Peter Schröder'
  s.description = 'Caches arbitrary data in files.'
  s.homepage = 'http://github.com/phoet/file_cache'
  s.summary = 'Caching is a need for nearly every application. Especially if you are integrating lots of external APIs. So just load the stuff and push it into a file - done!'

  s.has_rdoc = true
  s.rdoc_options = ['-a', '--inline-source', '--charset=UTF-8']
  s.extra_rdoc_files = ['README.rdoc']
  s.files = [ 'README.rdoc', 'lib/file_cache.rb' ]
  s.test_files = [ 'test/file_cache.rb' ]
end