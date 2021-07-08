module Elements
  class Earth < Element
    NAME = 'earth'
    MORNING_RULER = 'venus'
    NIGHT_RULER = 'moon'
    THIRD_RULER = 'mars'

    def initialize
      @name = NAME
      @morning_ruler = MORNING_RULER
      @night_ruler = NIGHT_RULER
      @third_ruler = THIRD_RULER
    end
  end
end
