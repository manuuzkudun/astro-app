module ZodiacSigns
  class Gemini < ZodiacSign
    DECANATES = %w(jupiter mars sun)
    TERMS = [['mercury', 6], ['jupiter', 12], ['venus', 17], ['mars', 24], ['saturn', 30]]
    RULER = 'mercury'
    ELEMENT = 'air'

    def initialize
      @name = 'gemini'
      @ruler = RULER
      @decanates = DECANATES
      @terms = TERMS
      @element = Elements::ElementFactory.create(ELEMENT)
    end
  end
end
