class Sniffer
  require 'zip'
  require 'csv'

  def initialize
    @conn = Communication.new
    @source = "sniffers" 
  end

  def call
    data = @conn.get_routes(@source)
    parsed_routes = parse_sniffers_data(data)
    response = @conn.post_routes(parsed_routes)
  end

  def parse_sniffers_data(data)
    final_routes = []
    Zip::File.open_buffer(data) do |zip|
      @routes = CSV.parse(zip.glob('*/routes.csv').first.get_input_stream.read.tr('"',''))
      @node_times = CSV.parse(zip.glob('*/node_times.csv').first.get_input_stream.read.tr('"',''))
      @sequences = CSV.parse(zip.glob('*/sequences.csv').first.get_input_stream.read.tr('"',''))
    end

    for i in 1...@sequences.size
      route_data = @routes.select{|a| a[0].to_i == @sequences[i][0].to_i}.first
      node_time  = @node_times.select{|a| a[0].to_i == @sequences[i][1].to_i}.first
      if route_data && node_time
        route = {
          source: @source ,
          start_node: node_time[1].strip, # for parse start node index 1 in array
          end_node: node_time[2].strip, #for parse end node index 2 in array
          start_time: route_data[1].strip, #it's already in utc 
          end_time: (route_data[1].to_datetime + (node_time[3].to_i/1000).seconds).strftime('%FT%T')
          #get the duration_in_seconds from node_time and added to the start time
        }
      end
      final_routes << route
    end
    final_routes
  end

end