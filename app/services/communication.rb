class Communication
  require 'zip'
  def initialize(source:)
    @url = "https://challenge.distribusion.com/the_one/routes"
    @source = source 
    @connection = Faraday.new(url: @url) do |faraday|
      faraday.response :logger
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_routes
    @response = @connection.get do |req|
        req.url @url
        req.params['source'] = @source
        req.params['passphrase'] = 'Kans4s-i$-g01ng-by3-bye'
      end 
     @loopholes = Loophole.new.call(@response.body)
  end
end 