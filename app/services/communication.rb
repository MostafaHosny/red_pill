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
     @loopholes = Sentinel.new.call(@response.body , @source)
  end
  
  def post_routes (routes)
    routes.each do |route|
     @response  = @connection.post do |req|
        req.url @url
        req.headers['Content-Type'] = 'application/json'
        req.body = route.merge(passphrase: 'Kans4s-i$-g01ng-by3-bye').to_json
      end
      byebug
      puts @response
    end
  end
end 