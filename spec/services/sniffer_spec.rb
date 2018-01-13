RSpec.describe Sniffer do
  context 'Sniffer parseing data' do
    before do
      @response_file = File.new("#{Rails.root}/test/fixtures/files/sniffers")
      @sniffer = Sniffer.new
      @parsed = @sniffer.parse_sniffers_data(@response_file)
    end
     
    it 'Should match the count of the parsed routes' do
      expect(@parsed.count).to eq(6)
    end

    it 'Should match the count of the paramters for post request' do
      expect(@parsed.first.keys.count).to eq(5)
    end

    it 'The first route should match the collected data' do
      expect(@parsed.first[:start_node]).to eq('lambda')
      expect(@parsed.first[:end_node]).to eq('tau')
    end

    it 'The last route should match the collected data' do
      expect(@parsed.last[:start_node]).to eq('psi')
      expect(@parsed.last[:end_node]).to eq('omega')
    end
  end

end 
