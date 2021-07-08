class Profile < ApplicationRecord
  has_one :user
  serialize :score_config
end
