class Api::CrunchbaseCompaniesController < ApplicationController
  def index
    render json: { crunchbase_companies: paginate(CrunchbaseCompany.all), count: CrunchbaseCompany.count }
  end
end
