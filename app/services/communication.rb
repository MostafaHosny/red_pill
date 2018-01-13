class Communication
  require 'zip'
  def initialize()
    @url = Rails.application.secrets.base_url 
    @passphrase = Rails.application.secrets.passphrase
    @connection = Faraday.new(url: @url) do |faraday|
      faraday.response :logger
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_routes(source)
    @response = @connection.get do |req|
      req.url @url
      req.params['source'] = source
      req.params['passphrase'] = @passphrase
    end
    @response.body
  end
  
  def post_routes (routes)
    routes.each do |route|
     @response  = @connection.post do |req|
        req.url @url
        req.headers['Content-Type'] = 'application/json'
        req.body = route.merge(passphrase: @passphrase).to_json
      end
    end
    @response
  end
end 