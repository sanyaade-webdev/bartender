require "multi_json"

require "bartender/configuration"
require "bartender/request"

require "bartender/beer"
require "bartender/brewery"

# Top-level interface to Bartender.
module Bartender
  # Bartender version.
  VERSION = "0.6.0"

  # Version of the Open Beer Database API.
  API_VERSION = "1"

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
