class Room < ApplicationRecord
  belongs_to :ralation, class_name: "Relationship"
  belongs_to :other_relation, class_name: "Relationship"

  validates :relationship_id, presence: true
  validates :other_relationship_id, presence: true
end
