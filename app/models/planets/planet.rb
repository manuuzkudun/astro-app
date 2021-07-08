module Planets
  class Planet
    attr_reader :current_sign, :sign_degree, :decanate, :name, :house, :speed

    def initialize(params)
      @name = params[:planet_name]
      @current_sign = ZodiacSigns::ZodiacSignFactory.create(params[:current_sign])
      @house = params[:house]
      @sign_degree = params[:sign_degree]
      @speed = params[:speed]
      @decanate = get_decanate(@current_sign, @sign_degree)
      @term = get_term(@current_sign, @sign_degree)
    end

    def to_s
      @name
    end

    (1..12).to_a.each do |i|
      method = "in_house_#{i}?".to_sym
      define_method method do
        @house == i
      end
    end

    def in_triplicity?(other_planets)
      sun = other_planets.select { |p| p.to_s == 'sun' }.first
      if sun.morning_chart?
        return @current_sign.element.morning_ruler == self.to_s
      else
        return @current_sign.element.night_ruler == self.to_s
      end
    end

    def in_domicile?
      @domiciles.any? { |d| d == @current_sign }
    end

    def in_exaltation?
      @exaltation == @current_sign
    end

    def in_detriment?
      @detriments.any? { |d| d == @current_sign }
    end

    def in_pilgrim_sign?
      @pilgrim_signs.any? { |s| s == @current_sign }
    end

    def in_fall?
      @fall == @current_sign
    end

    def in_joy?
      @house == @joy
    end

    def in_via_combusta?
      (@current_sign.in_libra? && @sign_degree >= 19) || (@current_sign.in_scorpio? && @sign_degree <= 20)
    end

    def in_decanate?
      @decanate == @name
    end

    def in_term?
      @term == @name
    end

    def direct?
      return false if luminare?
      @speed > 0
    end

    def retrograde?
      return false if luminare?
      @speed < 0
    end

    def fast?
      return false if luminare?
      (@speed/@avrg_speed).abs > 1.1
    end

    def slow?
      return false if luminare?
      (@speed/@avrg_speed).abs < 0.9
    end

    def stationary?
      (@speed/@avrg_speed).abs < 0.1
    end

    def in_reception_of_domiciles?(other_planets)
      result = false
      other_planets.each do |pl|
        next if pl == self
        if pl.domiciles.include?(self.current_sign) && self.domiciles.include?(pl.current_sign)
          result = true
        end
      end
      result
    end

    def in_reception_of_exaltation?(other_planets)
      result = false
      other_planets.each do |planet|
        next if planet == self
        if planet.exaltation == self.current_sign && self.exaltation == planet.current_sign
          result = true
        end
      end
      result
    end

    def disposition(other_planets)
      planet_count = 0
      other_planets.each do |planet|
        planet_count += 1 if planet.current_sign.ruler == self.to_s
      end
      planet_count
    end

    def get_signs(sign_list)
      sign_list.map { |sign_name| ::ZodiacSigns::ZodiacSignFactory.create(sign_name) }
    end

    def get_sign(sign_name)
      ZodiacSigns::ZodiacSignFactory.create(sign_name)
    end

    def get_decanate(zodiac_sign, degree)
      decs = zodiac_sign.decanates
      raise '3 decanates for a given sign' if decs.size != 3

      return decs.first if degree < 10
      return decs[1] if degree < 20
      return decs[2]
    end

    def get_term(zodiac_sign, degree)
      zodiac_sign.terms.select do |term_data|
        max_degree = term_data[1]
        degree < max_degree
      end.first.first
    end

    private

    def luminare?
      @name == 'sun' || @name == 'moon'
    end
  end
end
