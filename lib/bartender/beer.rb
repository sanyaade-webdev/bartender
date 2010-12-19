module Bartender
  # Retrieve information on beers.
  class Beer
    # Retrieve all beers.
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :column   The column to sort by (defaults to +id+).
    # @option options [String] :order    The order to sort by (defaults to +ASC+).
    # @option options [String] :page     The page number to request (defautls to +1+).
    # @option options [String] :per_page The number of beers to return per page (defaults to +50+).
    def self.all(options = {})
      Bartender::Request.get('/beers', options)
    end

    # Retrieve a specific beer.
    #
    # @param [Fixnum] id The ID of the beer to retrieve.
    def self.find(id)
      Bartender::Request.get("/beers/#{id}")
    end
  end
end
