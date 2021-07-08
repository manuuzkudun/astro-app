module Planets
  class Moon < Planet
    DOMICILES = %w(cancer).freeze
    EXALTATION = 'taurus'.freeze
    DETRIMENTS = %w(capricorn).freeze
    PILGRIM_SIGNS = %w(aries gemini leo virgo libra sagittarius aquarius).freeze
    FALL = 'scorpio'.freeze
    JOY = 1
    AVRG_SPEED = 13.1767

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
  end
end
