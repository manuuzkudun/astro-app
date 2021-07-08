module Elements
  class Fire < Element
    NAME = 'fire'
    MORNING_RULER = 'sun'
    NIGHT_RULER = 'jupiter'
    THIRD_RULER = 'saturn'

    def initialize
      @name = NAME
      @morning_ruler = MORNING_RULER
      @night_ruler = NIGHT_RULER
      @third_ruler = THIRD_RULER
    end
  end
end
