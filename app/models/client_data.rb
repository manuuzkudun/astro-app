class ClientData
  attr_reader :latitude, :longitude, :year, :month, :day, :hour, :altitude

  def initialize(params)
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @altitude = 0
    @year = params[:year].to_i
    @month = params[:month].to_i
    @day = params[:day].to_i
    @hour = params[:hour].to_f - 1
  end
end
