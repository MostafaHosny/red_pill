require 'rails_helper'

RSpec.describe ImporterController, type: :controller do
  before do

   stub_request(:post, "https://challenge.distribusion.com/the_one/routes").
         to_return(:status => 201, :body => "test", :headers => {})
  end

  describe 'post loopholes to system' do
    before do 
      response_file = File.new("#{Rails.root}/test/fixtures/files/loopholes")
      stub_request(:get, "#{Rails.application.secrets.base_url}?passphrase=Kans4s-i$-g01ng-by3-bye&source=loopholes").to_return(:status => 200, :body => response_file)
    end
    it 'status should be 201 (created)' do
      post 'loopholes'
      expect(response.status).to eq(201)
    end
  end

  describe 'post sentinels to system' do
    before do 
      response_file = File.new("#{Rails.root}/test/fixtures/files/sentinels")
      stub_request(:get, "#{Rails.application.secrets.base_url}?passphrase=Kans4s-i$-g01ng-by3-bye&source=sentinels").to_return(:status => 200, :body => response_file)
    end
    it 'status should be 201 (created)' do
      post 'sentinels'
      expect(response.status).to eq(201)
    end
  end

  describe 'post sniffers to system' do
    before do 
      response_file = File.new("#{Rails.root}/test/fixtures/files/sniffers")
      stub_request(:get, "#{Rails.application.secrets.base_url}?passphrase=Kans4s-i$-g01ng-by3-bye&source=sniffers").to_return(:status => 200, :body => response_file)
    end
    it 'status should be 201 (created)' do
      post 'sniffers'
      expect(response.status).to eq(201)
    end
  end
  
end
