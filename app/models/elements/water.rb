module Elements
  class Water < Element
    NAME = 'water'
    MORNING_RULER = 'venus'
    NIGHT_RULER = 'mars'
    THIRD_RULER = 'moon'

    def initialize
      @name = NAME
      @morning_ruler = MORNING_RULER
      @night_ruler = NIGHT_RULER
      @third_ruler = THIRD_RULER
    end
  end
end
