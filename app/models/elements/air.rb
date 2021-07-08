module Elements
  class Air < Element
    NAME = 'air'
    MORNING_RULER = 'saturn'
    NIGHT_RULER = 'mercury'
    THIRD_RULER = 'jupiter'

    def initialize
      @name = NAME
      @morning_ruler = MORNING_RULER
      @night_ruler = NIGHT_RULER
      @third_ruler = THIRD_RULER
    end
  end
end
