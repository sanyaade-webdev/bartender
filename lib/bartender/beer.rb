module Bartender
  # Retrieve information on beers.
  class Beer
    # Retrieve all beers.
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :order    The order to sort by (defaults to +id ASC+).
    # @option options [String] :page     The page number to request (defautls to +1+).
    # @option options [String] :per_page The number of beers to return per page (defaults to +50+).
    # @option options [String] :token    A public token to override the current configuration with (optional).
    def self.all(options = {})
      Bartender::Request.get("/beers", options)
    end

    # Create a beer.
    #
    # @param [Hash] attributes The attributes for the beer.
    # @option attributes [Integer] :brewery_id  The ID of the brewery the beer belongs to.
    # @option attributes [Hash]    :beer        The attributes for the beer.
    # @param [Hash] options The options for the API request.
    # @option options [String] :token A private token to override the current configuration with.
    # @return [String,Hash,false] The location of the new beer if created, errors hash for validation errors, +false+ otherwise.
    def self.create(attributes = {}, options = {})
      Bartender::Request.post("/beers", attributes, options)
    end

    # Deletes a beer.
    #
    # @param [Integer] id The ID of the beer to delete.
    # @param [Hash] options The options for the API request.
    # @option options [String] :token A private token to override the current configuration with (optional).
    # @return [Boolean] +true+ if successful, +false+ otherwise.
    def self.delete(id, options = {})
      Bartender::Request.delete("/beers/#{id}", options)
    end

    # Retrieve a specific beer.
    #
    # @param [Fixnum] id The ID of the beer to retrieve.
    # @param [Hash] options The options for the API request.
    # @option options [String] :token A public token to override the current configuration with (optional).
    def self.find(id, options = {})
      Bartender::Request.get("/beers/#{id}", options)
    end
  end
end
