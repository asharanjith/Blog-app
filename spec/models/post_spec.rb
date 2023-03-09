require 'rails_helper'

RSpec.describe Post, type: :model do
  testuser = User.create(name: 'sampleName', photo: 'www.google.com', bio: 'sample bio', postsCounter: 0)

  subject do
    Post.new(author: testuser, title: 'sample content', text: 'Samplt post content', likesCounter: 0,
             commentsCounter: 0)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'commentsCounter is a valid positive integer' do
    subject.commentsCounter = 0
    expect(subject).to be_valid
  end

  it 'likesCounter is a valid positive integer' do
    subject.likesCounter = 0
    expect(subject).to be_valid
  end

  it 'commentsCounter is not a valid negative integer' do
    subject.commentsCounter = -1
    expect(subject).to_not be_valid
  end

  it 'likesCounter is not a valid negative integer' do
    subject.likesCounter = -1
    expect(subject).to_not be_valid
  end

  it 'commentsCounter is not a valid string' do
    subject.commentsCounter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likesCounter is not a valid string' do
    subject.likesCounter = 'string'
    expect(subject).to_not be_valid
  end

  it 'returns recent comments' do
    Comment.create(author: testuser, post: subject, text: 'sample comment')
    comments = subject.recent_comments
    expect(comments).to eq([Comment.last])
    expect(comments.length).to eq(1)
  end
end
