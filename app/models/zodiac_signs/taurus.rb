module ZodiacSigns
  class Taurus < ZodiacSign
    DECANATES = %w(mercury moon saturn)
    TERMS = [['venus', 8], ['mercury', 14], ['jupiter', 22], ['saturn', 27], ['mars', 30]]
    RULER = 'venus'
    ELEMENT = 'earth'

    def initialize
      @name = 'taurus'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
