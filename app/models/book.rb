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
  scope :created_days_ago, ->(day) { where(created_at: "#{day}".to_i.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

  def self.post_conparison(target)
    if target.count > 0
      (self.count.to_f / target.count) * 100
    else
      '###'
    end
  end
end
