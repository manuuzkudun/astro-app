module ZodiacSigns
  class Libra < ZodiacSign
    DECANATES = %w(moon saturn jupiter)
    TERMS = [['saturn', 6], ['mercury', 14], ['jupiter', 21], ['venus', 28], ['mars', 30]]
    RULER = 'venus'
    ELEMENT = 'air'

    def initialize
      @name = 'libra'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
