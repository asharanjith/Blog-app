require 'rails_helper'

RSpec.describe Comment, type: :model do
  testuser = User.create(name: 'sampleName', photo: 'www.google.com', bio: 'sample bio', postsCounter: 0)
  testpost = Post.create(author: testuser, title: 'sample content', text: 'Samplt post content', likesCounter: 0,
                         commentsCounter: 0)

  subject do
    Comment.new(author: testuser, post: testpost, text: 'sample comment')
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'comments counter should be incremented by 1' do
    expect { subject.update_comments_counter }.to change { testpost.commentsCounter }.by(1)
  end
end
