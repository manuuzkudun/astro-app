module Planets
  class Sun < Planet
    DOMICILES = %w(leo).freeze
    EXALTATION = 'aries'.freeze
    DETRIMENTS = %w(aquarius).freeze
    PILGRIM_SIGNS = %w(taurus gemini cancer virgo scorpio capricorn pisces).freeze
    FALL = 'libra'.freeze
    JOY = 9
    AVRG_SPEED = 0.9856

    attr_reader :domiciles, :exaltation

    def initialize(params)
      super(params)
      @domiciles = get_signs(DOMICILES)
      @exaltation = get_sign(EXALTATION)
      @detriments = get_signs(DETRIMENTS)
      @fall = get_sign(FALL)
      @pilgrim_signs = get_signs(PILGRIM_SIGNS)
      @avrg_speed = AVRG_SPEED
      @joy = JOY
    end

    def morning_chart?
      @house >= 7
    end
  end
end
