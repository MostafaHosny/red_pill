class Loophole

  def initialize
  
  end
  require 'zip'
  def call(data)
    @content = {}
    routes = []
    Zip::File.open_buffer(data) do |zip|
      zip.each do |entry|
        unless entry.directory?
          data = JSON.parse(entry.get_input_stream.read)
          @content[data.keys.first] = data[data.keys.first]
          puts @content
        end
      end
      @content['routes'].each do | route|
       temp = @content['node_pairs'].select{ |a| a['id'] == route['node_pair_id']}.first
        unless temp.blank?
          ob = route.merge(temp)
          routes << ob
        end
      end
      byebug
    end
  end
end