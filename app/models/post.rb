class Post < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :author_id
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id
  after_save :update_posts_counter
  after_destroy :decrement_posts_counter

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :text, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :commentsCounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likesCounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter
    author.increment!(:postsCounter)
  end

  def decrement_posts_counter
    author.decrement!(:postsCounter)
  end
end
