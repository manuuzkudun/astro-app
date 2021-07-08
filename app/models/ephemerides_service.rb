class EphemeridesService
  ZODIAC_SIGNS = %w(aries taurus gemini cancer leo virgo libra scorpio
                    sagittarius capricorn aquarius pisces).freeze

  def initialize(client_data)
    @latitude = client_data.latitude
    @longitude = client_data.longitude
    @altitude = client_data.altitude
    @year = client_data.year
    @month = client_data.month
    @day = client_data.day
    @hour = client_data.hour
  end

  def get_data(planet)
    set_location
    planet_code = code_for(planet)
    data = Swe4r::swe_calc_ut(julian_day, planet_code, options)
    represent(planet, data)
  end

  private

  def represent(planet, data)
    planet_longitude = data[0]
    planet_speed = data[3]
    {
      planet_name: planet,
      longitude: planet_longitude,
      speed: planet_speed,
      current_sign: get_zodiac_sign(planet_longitude),
      sign_degree: planet_longitude % 30,
      house: in_house(planet_longitude)
    }
  end

  def options
    Swe4r::SEFLG_SPEED|Swe4r::SEFLG_TOPOCTR
  end

  def get_zodiac_sign(planet_longitude)
    n = (planet_longitude / 30).floor
    ZODIAC_SIGNS[n]
  end

  def in_house(planet_longitude)
    for i in 0..houses.length - 2
      cusp = houses[i]
      next_cusp = houses[i+1]
      if cusp < next_cusp
        if in_sector?(planet_longitude, cusp, next_cusp)
          return i + 1
        end
      else
        if in_sector?(planet_longitude, cusp, 360) || in_sector?(planet_longitude, 0, next_cusp)
          return i + 1
        end
      end
    end
  end

  def code_for(planet)
    case planet
    when 'sun'
      return Swe4r::SE_SUN
    when 'moon'
      return Swe4r::SE_MOON
    when 'mercury'
      return Swe4r::SE_MERCURY
    when 'venus'
      return Swe4r::SE_VENUS
    when 'mars'
      return Swe4r::SE_MARS
    when 'jupiter'
      return Swe4r::SE_JUPITER
    when 'saturn'
      return Swe4r::SE_SATURN
    else
      raise "planet #{planet}} not known"
    end
  end

  def houses
    @houses ||= Swe4r::swe_houses(julian_day, @latitude, @longitude, 'P')[1..13]
  end

  def set_location
    Swe4r::swe_set_topo(@longitude, @latitude, @altitude)
  end

  def julian_day
    Swe4r::swe_julday(@year, @month, @day, @hour)
  end

  def in_sector?(latitude, cusp1, cusp2)
    latitude >= cusp1 && latitude < cusp2
  end
end
