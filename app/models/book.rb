class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

	validates :title,presence:true
	validates :body,presence:true,length:{maximum:200}

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.book_find_recode(keyword)
    where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # 投稿数を数えるためのスコープ
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }

  def self.post_conparison(target)
    if target.count > 0
      number_to_percentage(self.count / target.count)
    else
      '###'
    end
  end
end
