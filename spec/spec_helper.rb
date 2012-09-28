require 'rubygems'
require 'bundler/setup'

require 'rack/maintenance'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  # some optional config here
end
