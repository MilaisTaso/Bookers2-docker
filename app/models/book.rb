class Book < ApplicationRecord
  enum category: {
    novel: 1,
    picture: 2,
    technical: 3,
    business: 4,
    magazine: 5,
    comic: 6
  }
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

	validates :title,presence:true
	validates :body,presence:true,length:{maximum:200}
	validates :category,presence:true

  scope :score_desc, -> { order(score: :desc)}
  scope :about_category, ->(category) {where(category: category)}

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.book_find_recode(keyword)
    where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
