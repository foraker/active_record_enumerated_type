require 'bundler/setup'
Bundler.setup

require 'active_support/core_ext'
require 'enumerated_type'
require 'active_record_enumerated_type'

class Status
  include EnumeratedType

  declare :started
  declare :finished
end

RSpec.configure do |config|
end