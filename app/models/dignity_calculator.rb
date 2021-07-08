class DignityCalculator
  ESSENTIAL_DIGNITIES = %w(domicile exaltation detriment fall pilgrim domicile_reception
                           exaltation_reception decanate triplicity term via_combusta).freeze
  ACCIDENTAL_DIGNITIES = %w(in_house_1 in_house_2 in_house_3 in_house_4 in_house_5 in_house_6
                            in_house_7 in_house_8 in_house_9 in_house_10 in_house_11 in_house_12
                            direct retrograde fast slow stationary in_joy dispositor).freeze

  def initialize(planets, score_config)
    @score_config = score_config
    @planets = planets
    @dignity_methods = YAML.load_file('./app/models/dignity_methods.yml')
  end

  # TO-DO: Refractor
  def calculate_for(planet)
    results = {}
    total_score = 0

    results[:essential_dignities] = {}
    ESSENTIAL_DIGNITIES.each do |dignity|
      score = get_dignity_score(planet, dignity)
      total_score += score
      results[:essential_dignities][dignity.to_sym] = {
        result: !score.zero?,
        score: score
      }
    end

    results[:accidental_dignities] = {}
    ACCIDENTAL_DIGNITIES.each do |dignity|
      score = get_dignity_score(planet, dignity)
      total_score += score
      results[:accidental_dignities][dignity.to_sym] = {
        result: !score.zero?,
        score: score
      }
    end
    results["total_score"] = total_score
    results
  end

  private

  def get_dignity_score(planet, dignity)
    method = @dignity_methods[dignity]['method']
    score = @score_config[dignity]['score']

    case dignity
    when 'dispositor'
      planet_count = planet.send(method, @planets)
      dignified = planet_count > 0
      score =  score * planet_count
    when 'domicile_reception'
      dignified = planet.send(method, @planets)
    when 'exaltation_reception'
      dignified = planet.send(method, @planets)
    when 'triplicity'
      dignified = planet.send(method, @planets)
    else
      dignified = planet.send(method)
    end

    return dignified ? score : 0
  end
end
