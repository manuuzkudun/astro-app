module ZodiacSigns
  class Aquarius < ZodiacSign
    DECANATES = %w(venus mercury moon)
    TERMS = [['mercury', 7], ['venus', 13], ['jupiter', 20], ['mars', 25], ['saturn', 30]]
    RULER = 'saturn'
    ELEMENT = 'air'

    def initialize
      @name = 'aquarius'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
