class ClientData
  attr_reader :latitude, :longitude, :altitude, :year, :month, :day, :hour, :local_time

  def initialize(params)
    # binding.pry
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @altitude = 0
    @year = params[:year].to_i
    @month = params[:month].to_i
    @day = params[:day].to_i
    # data = params[:hour].delete(' ').split(':')
    @hour = params[:hour].to_f
    # @minutes = data.last.to_i
  end

  def local_time
    # timezone = Timezone.lookup(@latitude, @longitude)
    # date_time = DateTime.new(@year,@month,@day,@hour -1, @minutes,0)
    date_time = DateTime.new(@year,@month,@day,@hour)
    # timezone.utc_to_local(date_time)
  end
end
