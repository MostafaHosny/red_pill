class Sentinel
  require 'csv'
  require 'zip'

  def initialize
    @conn = Communication.new
    @source = "sentinels" 
  end

  def call
    data = @conn.get_routes(@source)
    parsed_routes = parse_sentinels_data(data)
    response = @conn.post_routes(parsed_routes)
  end

  def parse_sentinels_data(data)
    final_routes = []
    Zip::File.open_buffer(data) do |zip|
      data = CSV.parse(zip.to_a[1].get_input_stream.read.tr('"',''))
    end

    for i in 1..(data.size-1)
      start_index = i ; end_index = i+1
      if data[end_index] && data[start_index][2].to_i + 1 == data[end_index][2].to_i
        route = {
          source: @source ,
          start_node: data[start_index][1].strip,
          end_node: data[end_index][1].strip,
          start_time: data[start_index][3].to_datetime.utc.strftime('%FT%T'),
          end_time: data[end_index][3].to_datetime.utc.strftime('%FT%T') 
        }
       final_routes << route 
      end
    end
    final_routes
  end

end