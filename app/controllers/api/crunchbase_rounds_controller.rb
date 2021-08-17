class Api::CrunchbaseRoundsController < ApplicationController
  def index
    render json: { rounds: paginate(CrunchbaseRound.all), count: CrunchbaseRound.count }
  end
end
