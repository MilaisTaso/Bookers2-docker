class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :created_today, -> {where("created_at >=")}
end
