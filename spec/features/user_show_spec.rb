require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    visit user_session_path
    @photo = 'https://images.unsplash.com/photo-1648974299612-679d6fb46816?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
    @user_one = User.create(name: 'Jake', photo: @photo, bio: 'Lorem ipsum dolor sit amet', email: 'jake@example.com',
                            password: 'jake123', posts_counter: 6)
    fill_in 'Email', with: 'jake@example.com'
    fill_in 'Password', with: 'jake123'
    click_button 'Log in'
    @post1 = @user_one.posts.create!(title: 'Programming',
                                     text: 'I am a programmer',
                                     likes_counter: 0,
                                     comments_counter: 0)
    @post2 = @user_one.posts.create!(title: 'Skies',
                                     text: 'Blue skies',
                                     likes_counter: 0,
                                     comments_counter: 0)
    @post3 = @user_one.posts.create!(title: 'One more time',
                                     text: 'I want to see the world again',
                                     likes_counter: 0,
                                     comments_counter: 6)
    visit user_path(@user_one)
  end

  it 'Should see the user\'s profile picture' do
    image_src = page.find('img')['src']
    expect(image_src).to eql @photo
  end

  it 'Should see the user\'s username' do
    expect(page).to have_content 'Jake'
  end

  it 'Should see the number of posts the user has written' do
    expect(page).to have_content 'Number of posts: '
  end

  it 'Should see the user\'s bio' do
    expect(page).to have_content 'Lorem ipsum dolor sit amet'
  end

  it 'Should see the user\'s first 3 posts.' do
    expect(page).to have_content 'I am a programmer'
    expect(page).to have_content 'Blue skies'
    expect(page).to have_content 'I want to see the world again'
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
    click_link 'See all posts'
    expect(page).to have_current_path user_posts_path(@user_one)
  end
end
