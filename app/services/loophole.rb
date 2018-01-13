class Loophole
  require 'zip'

  def initialize
    @conn = Communication.new
    @source = "loopholes" 
  end

  
  def call
    data = @conn.get_routes(@source)
    parsed_routes = parse_loopholes_data(data)
    response = @conn.post_routes(parsed_routes)
  end

  def parse_loopholes_data(data)
    @content = {}
    routes = []
    Zip::File.open_buffer(data) do |zip|
      zip.each do |entry|
        unless entry.directory?
          data = JSON.parse(entry.get_input_stream.read)
          @content[data.keys.first] = data[data.keys.first]
        end
      end
    end
    @content['routes'].each do | route|
      temp = @content['node_pairs'].select{ |a| a['id'] == route['node_pair_id']}.first
        unless temp.blank?
          final_route = route.merge(temp).merge( source: @source).except('route_id' , 'node_pair_id' , 'id')
          final_route['start_time'] = final_route['start_time'].to_datetime.strftime('%FT%T')
          final_route['end_time'] = final_route['end_time'].to_datetime.strftime('%FT%T')
          routes << final_route
        end
      end
    routes
  end

end