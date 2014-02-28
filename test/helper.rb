require 'rubygems'
require 'test/unit'
# require 'webmock/test_unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'the_castle_client'

class Test::Unit::TestCase
end
