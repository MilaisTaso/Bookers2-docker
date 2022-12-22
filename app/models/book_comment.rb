class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, presence: true

  def self.comment_find_recode(keyword)
    where(["comment like?", "%#{keyword}%"])
  end
end
