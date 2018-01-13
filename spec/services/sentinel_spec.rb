RSpec.describe Sentinel do
  context 'Sentinel parseing data' do
    before do
      @response_file = File.new("#{Rails.root}/test/fixtures/files/sentinels")
      @sentinel = Sentinel.new
      @parsed = @sentinel.parse_sentinels_data(@response_file)
    end
     
    it 'Should match the count of the parsed routes' do
      expect(@parsed.count).to eq(4)
    end

    it 'Should match the count of the paramters for post request' do
      expect(@parsed.first.keys.count).to eq(5)
    end

    it 'The first route should match the collected data' do
      expect(@parsed.first[:start_node]).to eq('alpha')
      expect(@parsed.first[:end_node]).to eq('beta')
    end

    it 'The last route should match the collected data' do
      expect(@parsed.last[:start_node]).to eq('beta')
      expect(@parsed.last[:end_node]).to eq('gamma')
    end
  end

end 
