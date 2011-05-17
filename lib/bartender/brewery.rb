module Bartender
  # Retrieve information on breweries.
  class Brewery
    # Retrieve all breweries.
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :order    The order to sort by (defaults to +id ASC+).
    # @option options [String] :page     The page number to request (defautls to +1+).
    # @option options [String] :per_page The number of breweries to return per page (defaults to +50+).
    def self.all(options = {})
      Bartender::Request.get("/breweries", options)
    end

    # Retrieve a specific brewery.
    #
    # @param [Fixnum] id The ID of the brewery to retrieve.
    def self.find(id)
      Bartender::Request.get("/breweries/#{id}")
    end
  end
end
