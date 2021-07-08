module ZodiacSigns
  class Aries < ZodiacSign
    DECANATES = %w(mars sun venus)
    TERMS = [['jupiter', 6], ['venus', 12], ['mercury', 20], ['mars', 25], ['saturn', 30]]
    RULER = 'mars'
    ELEMENT = 'fire'

    def initialize
      @name = 'aries'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
