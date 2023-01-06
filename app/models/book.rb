class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  is_impressionable counter_cache: true

	validates :title,presence:true
	validates :body,presence:true,length:{maximum:200}

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.book_find_recode(keyword)
    where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
