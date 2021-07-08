module ZodiacSigns
  class Cancer < ZodiacSign
    DECANATES = %w(venus mercury moon)
    TERMS = [['mars', 6], ['venus', 12], ['mercury', 18], ['jupiter', 25], ['saturn', 30]]
    RULER = 'moon'
    ELEMENT = 'water'

    def initialize
      @name = 'cancer'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
