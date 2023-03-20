require 'rails_helper'

RSpec.describe 'users#show', type: :feature do
  before(:each) do
    @user = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')
    @post_one = Post.create(author_id: @user.id, title: 'My first post', text: 'This is my first post')
    @post_second = Post.create(author_id: @user.id, title: 'My second post', text: 'This is my second post')

    Comment.create(author_id: @user.id, post_id: @post_one.id, text: 'This is my first comment')
    Comment.create(author_id: @user.id, post_id: @post_one.id, text: 'This is my second comment')


    visit user_path(@user.id)
  end

  it 'can see the name of the user' do
    expect(page).to have_content('John Doe')
  end

  it 'can see the photo of the user' do
    expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
  end

  it 'can see the bio of the user' do
    expect(page).to have_content('I am a developer')
  end

  it 'can see the count of the posts of the user' do
    expect(page).to have_content('2')
  end

  it 'can see the 3 recent posts of the user' do
    recent_posts = @user.recent_posts
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'can see the count of the comments of the user' do
    expect(page).to have_content('2')
  end

  it 'can see the button to see all the posts of the user' do
    expect(page).to have_link('See all posts')
  end

  it 'can redirect to the user posts index page' do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user.id))
  end

  it 'link to the post show page' do
    click_link(@post_one.title)
    expect(page).to have_content(@post_one.title)
    expect(page).to have_content(@post_one.text)
    expect(page).to have_current_path(user_post_path(@user.id, @post_one.id))
  end
end
