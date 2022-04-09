require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    visit user_session_path
    @photo = 'https://images.unsplash.com/photo-1648974299612-679d6fb46816?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
    @user_one = User.create(name: 'Jake',
                            photo: @photo, email: 'jake@example.com', password: 'jake123', posts_counter: 1)
    @user_two = User.create(name: 'Pablo',
                            photo: @photo, email: 'pablo@example.com', password: 'pablo123', posts_counter: 0)
    @user_three = User.create(name: 'Lucy',
                              photo: @photo, email: 'lucy@example.com', password: 'lucy123', posts_counter: 8)
    fill_in 'Email', with: 'jake@example.com'
    fill_in 'Password', with: 'jake123'
    click_button 'Log in'
    visit users_path
  end

  it 'should see the username of all other users.' do
    expect(page).to have_content('Jake')
    expect(page).to have_content('Pablo')
    expect(page).to have_content('Lucy')
  end

  it 'Should see the profile picture for each user.' do
    images = page.all('img')
    user_names = page.all('div h2')
    expect(images.size).to eql(user_names.size)
  end

  it 'Should see the number of posts each user has written.' do
    subscribers = page.all('.card')
    expect(subscribers[0]).to have_content 'Number of posts: 1'
    expect(subscribers[1]).to have_content 'Number of posts: 0'
    expect(subscribers[2]).to have_content 'Number of posts: 8'
  end
end
