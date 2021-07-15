class ClientData
  attr_reader :latitude, :longitude, :altitude, :local_time

  def initialize(params)
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @altitude = 0
    @year = params[:year].to_i
    @month = params[:month].to_i
    @day = params[:day].to_i
    data = params[:hour].delete(' ').split(':')
    @hour = data.first.to_i
    @minutes = data.last.to_i
  end

  def local_time
    timezone = Timezone.lookup(@latitude, @longitude)
    date_time = DateTime.new(@year,@month,@day,@hour, @minutes,0)
    timezone.utc_to_local(date_time)
  end
end
