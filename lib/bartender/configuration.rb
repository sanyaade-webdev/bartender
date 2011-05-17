module Bartender
  # Used to store settings for API connections and requests.
  class Configuration
    # @return [String] The host to connect to (defaults to +api.openbeerdatabase.com+).
    attr_accessor :host

    # @return [Fixnum] The port on which the Open Beer Database API runs (defaults to +80+).
    attr_accessor :port

    # @return [String] The public API token for your user.
    attr_accessor :public_token

    # @return [String] The private API token for your user.
    attr_accessor :private_token

    # @return [Fixnum] The HTTP open timeout in seconds (defaults to +2+).
    attr_accessor :http_open_timeout

    # @return [Fixnum] The HTTP read timeout in seconds (defaults to +2+).
    attr_accessor :http_read_timeout

    # Instantiated from {Bartender.configuration}. Sets defaults.
    def initialize
      self.host              = 'api.openbeerdatabase.com'
      self.port              = 80
      self.http_open_timeout = 2
      self.http_read_timeout = 2
    end
  end
end
