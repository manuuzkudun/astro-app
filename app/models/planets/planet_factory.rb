module Planets
  class PlanetFactory
    def self.create(params)
      case params[:planet_name]
      when 'sun'
        return Planets::Sun.new(params)
      when 'moon'
        return Planets::Moon.new(params)
      when 'mercury'
        return Planets::Mercury.new(params)
      when 'venus'
        return Planets::Venus.new(params)
      when 'mars'
        return Planets::Mars.new(params)
      when 'jupiter'
        return Planets::Jupiter.new(params)
      when 'saturn'
        return Planets::Saturn.new(params)
      else
        raise "planet #{params[:planet_name]} not known"
      end
    end
  end
end