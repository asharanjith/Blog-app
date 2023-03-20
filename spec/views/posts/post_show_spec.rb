require 'rails_helper'

RSpec.describe 'posts#show', type: :feature do
  before(:each) do
    @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')
    @user_second = User.create(name: 'Jane Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')

    @post = Post.create(author_id: @user.id, title: 'My first post', text: 'This is my first post')

    Comment.create(author_id: @user_second.id, post_id: @post.id, text: 'This is my first comment')

    visit user_post_path(@user.id, @post.id)
  end

  it 'can see the title of the post' do
    expect(page).to have_content('This is my first post')
  end

  it 'can see the author of the post' do
    expect(page).to have_content('John Doe')
  end

  it 'can see how many comments the post has' do
    expect(page).to have_content('1')
  end

  it 'can see how many likes the post has' do
    expect(page).to have_content('0')
  end

  it 'can see the text of the post' do
    expect(page).to have_content('This is my first post')
  end

  it 'can see the username of the comment author' do
    expect(page).to have_content('Jane Doe')
  end

  it 'can see the text of the comment' do
    expect(page).to have_content('This is my first comment')
  end
end
