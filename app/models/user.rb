class User < ApplicationRecord
  before_create :default_image_attach
  #Ex:- :default =>''
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  #フォロワー機能のリレーション
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def default_image_attach
    if !self.profile_image.attached?
      self.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpg')), filename: 'no_image.jpg', content_type: 'image/jpag')
    end
  end

  def image_resize(width, height)
    self.profile_image.variant(resize_to_limit: [width, height])
  end

  # relationship モデルに関するメソッド
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def mutual_followed?(user)
    self.following.exists?(id: user) && self.followers.exists?(id: user)
  end

  def self.user_find_recode(keyword)
    where(["name like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
