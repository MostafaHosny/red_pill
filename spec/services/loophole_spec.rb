RSpec.describe Loophole do
  context 'Loophole parseing data' do
    before do
      @response_file = File.new("#{Rails.root}/test/fixtures/files/loopholes")
      @loophole = Loophole.new
      @parsed = @loophole.parse_loopholes_data(@response_file)
    end
     
    it 'Should match the count of the parsed routes' do
      expect(@parsed.count).to eq(4)
    end

    it 'Should match the count of the paramters for post request' do
      expect(@parsed.first.keys.count).to eq(5)
    end

    it 'The first route should match the collected data' do
      expect(@parsed.first['start_node']).to eq('gamma')
      expect(@parsed.first['end_node']).to eq('theta')
    end

    it 'The last route should match the collected data' do
      expect(@parsed.last['start_node']).to eq('theta')
      expect(@parsed.last['end_node']).to eq('lambda')
    end
  end
end 
