require 'rails_helper'

RSpec.describe Like, type: :model do
  testuser = User.create(name: 'sampleName', photo: 'www.google.com', bio: 'sample bio', postsCounter: 0)
  testpost = Post.create(author: testuser, title: 'sample content', text: 'Samplt post content', likesCounter: 0,
                         commentsCounter: 0)

  subject do
    Like.new(author: testuser, post: testpost)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'likes counter should be incremented by 1' do
    expect { subject.update_likes_counter }.to change { testpost.likesCounter }.by(1)
  end
end
