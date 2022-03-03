class ClientData
  attr_reader :latitude, :longitude, :altitude, :year, :month, :day, :hour, :minutes, :local_time

  def initialize(params)
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @altitude = 0
    @year = params[:year].to_i
    @month = params[:month].to_i
    @day = params[:day].to_i
    data = params[:hour].delete(' ').split(':')
    @hour = params[:hour].to_i
    #@minutes = params[:minutes].to_i
    @minutes = data.last.to_i
    @hour = compiled_time
  end

  def compiled_time
    #binding.pry
    timezone = Timezone.lookup(@latitude,@longitude)
    date = DateTime.new(@year,@month,@day,@hour,@minutes)
    time_offset = (timezone.time_with_offset(date)).gmt_offset.to_i / 3600
    result = ((@hour + (-(time_offset))) + ((@minutes * 100 / 60).to_f / 100)).to_f
  end

  def local_time
    # timezone = Timezone.lookup(@latitude, @longitude)
    # date_time = DateTime.new(@year,@month,@day,@hour -1, @minutes,0)
    date_time = DateTime.new(@year,@month,@day,@hour)
    # timezone.utc_to_local(date_time)
  end
end
