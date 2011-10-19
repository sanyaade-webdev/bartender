require "cgi"
require "net/http"

module Bartender
  # @private
  class Request
    def self.delete(path, options = {})
      options[:token] ||= Bartender.configuration.private_token

      response = request.delete(uri(path, options))
      response.code.to_i == 200
    end

    def self.get(path, options = {})
      token = Bartender.configuration.public_token

      unless token.nil?
        options[:token] ||= token
      end

      response = request.get(uri(path, options))

      case response.code.to_i
      when 200
        Yajl::Parser.parse(response.body)
      else
        false
      end
    end

    def self.post(path, attributes = {}, options = {})
      options[:token] ||= Bartender.configuration.private_token

      response = request.post(uri(path, options), Yajl::Encoder.encode(attributes), "Content-Type" => "application/json")

      case response.code.to_i
      when 201
        response["Location"]
      when 400
        Yajl::Parser.parse(response.body)["errors"]
      else
        false
      end
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
