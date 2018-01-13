class ImporterController < ApplicationController
  
  def sentinels
    response = Sentinel.new.call
    render json: response.body, status: response.status 
  end
  
  def sniffers
    response = Sniffer.new.call
    render json: response.body, status: response.status
  end
  
  def loopholes
    response = Loophole.new.call
    render json: response.body, status: response.status
  end

end
