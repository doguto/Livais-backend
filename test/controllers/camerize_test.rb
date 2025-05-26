require 'active_support'
require 'active_support/core_ext/string/inflections'

puts({ "foo_foo" => "bar_jo", "baz_rin" => 12 }.camelize)  if __FILE__ == $0
