require "yajl/json_gem"

require "bartender/configuration"
require "bartender/request"
require "bartender/version"

require "bartender/beer"
require "bartender/brewery"

# Top-level interface to Bartender.
module Bartender
  # Call this method to modify defaults in your initializers.
  #
  # @example
  #   Bartender.configure do |configuration|
  #     configuration.http_open_timeout = 1
  #     configuration.http_read_timeout = 1
  #   end
  #
  # @yield [Configuration] The current configuration.
  def self.configure
    yield(configuration)
  end

  # @return [Configuration] Current configuration.
  def self.configuration
    @@configuration ||= Configuration.new
  end
end
