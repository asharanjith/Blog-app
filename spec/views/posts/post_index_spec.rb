require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  before(:each) do
    @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')
    @user2 = User.create(name: 'Jane Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')
    @post_one = Post.create(author_id: @user.id, title: 'My first post', text: 'This is my first post')
    @post_second = Post.create(author_id: @user.id, title: 'My second post', text: 'This is my second post')

    Comment.create(author_id: @user2.id, post_id: @post_one.id, text: 'This is my first comment')

    visit user_posts_path(@user.id)
  end

  it 'can see the title of the post' do
    expect(page).to have_content('This is my first post')
    expect(page).to have_content('This is my second post')
  end

  it 'can see the number of posts' do
    expect(page).to have_content('2')
  end

  it 'can see the photo of the author of the post' do
    expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
  end

  it 'can see the text of the post' do
    expect(page).to have_content('This is my first post')
    expect(page).to have_content('This is my second post')
  end

  it 'can see the count of the comments of the post' do
    expect(page).to have_content('1')
  end

  it 'can see a button to create a new post' do
    expect(page).to have_link('Create new post')
  end

  it 'can see how many likes the post has' do
    expect(page).to have_content('0')
  end

  it 'can see the details of the post when clicking on the title' do
    click_link 'This is my second post'
    expect(page).to have_current_path(user_post_path(@user.id, @post_second.id))
  end
end
