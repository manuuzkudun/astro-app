class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile

  before_create :build_default_profile

  private

  def build_default_profile
    default_score_config = YAML.load_file('./app/models/dignity_scores.yml')
    build_profile(name: 'default score config', score_config: default_score_config)
  end
end
