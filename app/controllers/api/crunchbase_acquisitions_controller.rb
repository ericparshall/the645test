class Api::CrunchbaseAcquisitionsController < ApplicationController
  def index
    render json: { crunchbase_acquisitions: paginate(CrunchbaseAcquisition.all), count: CrunchbaseAcquisition.count }
  end
end
