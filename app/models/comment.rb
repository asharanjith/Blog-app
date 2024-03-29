class Comment < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id

  after_save :update_comments_counter
  after_destroy :decrement_comments_counter

  def update_comments_counter
    post.increment!(:commentsCounter)
  end

  def decrement_comments_counter
    post.decrement!(:commentsCounter)
  end
end
