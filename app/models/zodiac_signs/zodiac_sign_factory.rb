module ZodiacSigns
  class ZodiacSignFactory
    def self.create(name)
      case name
      when 'aries'
        return ZodiacSigns::Aries.new
      when 'taurus'
        return ZodiacSigns::Taurus.new
      when 'gemini'
        return ZodiacSigns::Gemini.new
      when 'cancer'
        return ZodiacSigns::Cancer.new
      when 'leo'
        return ZodiacSigns::Leo.new
      when 'virgo'
        return ZodiacSigns::Virgo.new
      when 'libra'
        return ZodiacSigns::Libra.new
      when 'scorpio'
        return ZodiacSigns::Scorpio.new
      when 'sagittarius'
        return ZodiacSigns::Sagittarius.new
      when 'capricorn'
        return ZodiacSigns::Capricorn.new
      when 'aquarius'
        return ZodiacSigns::Aquarius.new
      when 'pisces'
        return ZodiacSigns::Pisces.new
      else
        raise "zodiac sign #{name} not known"
      end
    end
  end
end