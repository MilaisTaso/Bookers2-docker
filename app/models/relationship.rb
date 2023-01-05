class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :rooms, class_name: "Room", foreign_key: :relationship_id, dependent: :destroy
  has_many :room_menber, through: :rooms, source: :other_relation

  has_many :other_rooms, class_name: "Room", foreign_key: :other_relationship_id, dependent: :destroy
  has_many :ohter_room_menber, through: :other_rooms, source: :relation

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def add_room(relationship_id)
    rooms.create(other_relationship_id: relationship_id)
  end
end
