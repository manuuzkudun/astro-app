module ZodiacSigns
  class Sagittarius < ZodiacSign
    DECANATES = %w(mercury moon saturn)
    TERMS = [['jupiter', 12], ['venus', 17], ['mercury', 21], ['saturn', 26], ['mars', 30]]
    RULER = 'jupiter'
    ELEMENT = 'fire'

    def initialize
      @name = 'sagittarius'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
