class PlanetsDignitiesController < ApplicationController
  PLANET_NAMES = %w(sun moon mercury venus mars jupiter saturn)

  def new
  end

  def show
    client_data = ClientData.new(permitted_params)
    ephemerides = EphemeridesService.new(client_data)

    planetsData = PLANET_NAMES.map do |planet|
      ephem_data = ephemerides.get_data(planet)
      planet = Planets::PlanetFactory.create(ephem_data)
    end

    dignity_calculator = DignityCalculator.new(planetsData, score_config)

    @planets_dignities = planetsData.map do |planet|
      {
        "planet_name": planet.name,
        "current_sign": planet.current_sign,
        "speed": planet.speed,
        "house": planet.house,
        "sign_degree": planet.sign_degree,
        "dignities":dignity_calculator.calculate_for(planet)
      }
    end
  end

  private

  def score_config
    if current_user && current_user.profile && current_user.profile.score_config
      current_user.profile.score_config
    else
      YAML.load_file('./app/models/dignity_scores.yml')
    end
  end

  def permitted_params
    params.permit("latitude", "longitude", "year", "month", "day", "hour")
  end
end
