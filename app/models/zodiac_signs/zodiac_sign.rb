module ZodiacSigns
  class ZodiacSign
    attr_reader :name, :ruler, :decanates, :terms, :element

    ZODIAC_SIGNS = %w(aries taurus gemini cancer leo virgo libra scorpio sagittarius
                      capricorn aquarius pisces).freeze
    def to_s
      @name
    end

    def ==(another_sign)
      self.name == another_sign.name
    end

    ZODIAC_SIGNS.each do |sign|
      method = "in_#{sign}?".to_sym
      define_method method do
        @name == sign
      end
    end
  end
end
