module ZodiacSigns
  class Capricorn < ZodiacSign
    DECANATES = %w(jupiter mars sun)
    TERMS = [['mercury', 7], ['jupiter', 14], ['venus', 22], ['saturn', 26], ['mars', 30]]
    RULER = 'saturn'
    ELEMENT = 'earth'

    def initialize
      @name = 'capricorn'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
