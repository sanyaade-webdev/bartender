require "cgi"
require "net/http"

module Bartender
  # @private
  class Request
    def self.get(path, options = {})
      token = Bartender.configuration.public_token

      unless token.nil?
        options[:token] ||= token
      end

      JSON.parse(request.get(uri(path, options)).body)
    end

    def self.request
      http = Net::HTTP.new(Bartender.configuration.host, Bartender.configuration.port)
      http.open_timeout = Bartender.configuration.http_open_timeout
      http.read_timeout = Bartender.configuration.http_read_timeout
      http
    end

    def self.uri(path, options = {})
      "/v#{API_VERSION}#{path}.json?#{hash_to_query_string(options)}"
    end

    def self.hash_to_query_string(hash)
      hash.sort_by { |key, value|
        key.to_s
      }.delete_if { |key, value|
        value.to_s.empty?
      }.collect { |key, value|
        "#{CGI.escape(key.to_s).gsub(/%(5B|5D)/n) { [$1].pack("H*") }}=#{CGI.escape(value.to_s)}"
      }.join("&")
    end
  end
end
