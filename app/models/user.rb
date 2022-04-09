class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  :confirmable
  validates :name, presence: true, allow_blank: false
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  def fetch_recent_posts
    posts.order('created_at DESC').limit(3)
  end

  def admin?
    role == 'admin'
  end
end
