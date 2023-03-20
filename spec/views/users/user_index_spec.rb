require 'rails_helper'

RSpec.describe 'users#index', type: :feature do
  before(:each) do
    @user_one = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')
    @second_user = User.create(name: 'Jane Doe', photo: 'https://picsum.photos/200/300', bio: 'I am a developer')
    @post_one = Post.create(author_id: @user_one.id, title: 'My first post', text: 'This is my first post')
    @post_second = Post.create(author_id: @user_one.id, title: 'My second post', text: 'This is my second post')

    visit users_path
  end

  it 'can see the name of the user' do
    expect(page).to have_content('John Doe')
    expect(page).to have_content('Jane Doe')
  end

  it 'can see the photo of the user' do
    expect(page).to have_css("img[src*='https://picsum.photos/200/300']")
  end

  it 'can see the count of the posts of the user' do
    expect(page).to have_content('2')
  end

  it 'link to the user show page' do
    click_link(@user_one.name)
    expect(page).to have_content(@user_one.name)
    expect(page).to have_content(@user_one.bio)
    expect(page).to have_current_path(user_path(@user_one.id))
  end
end
