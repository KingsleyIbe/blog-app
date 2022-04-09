require 'rails_helper'

RSpec.describe 'users#index', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create(name: 'Amy', photo: 'image1.jpg', bio: 'bio', posts_counter: 0, email: 'amy@gmail.com',
                           password: 'password')
      @user2 = User.create(name: 'Amy', bio: 'bio',
                           photo: 'image1.jpg',
                           email: 'amy@gmail.com', password: 'password')
      @user3 = User.create(name: 'Jerry', bio: 'bio',
                           photo: 'image1.jpg',
                           email: 'jerry@gmail.com', password: 'password')
      visit root_path
      fill_in 'Email', with: 'amy@gmail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end

    it 'Shows the username' do
      expect(page).to have_content('Amy')
    end

    it "Shows the user's photo" do
      all('img').each do |i|
        expect(i[:src]).to eq('/assets/image1-f893171ac7386418fbe290a681d9c12a7fecc5946afd70dccdb96626edfc7694.jpg')
      end
    end

    it 'Shows the number of posts' do
      all(:css, '.num_post').each do |post|
        expect(post).to have_content('Number of posts: 0')
      end
    end

    it "after clicking on the user, it will be redirected to that user's show page" do
      expect(page).to have_content('Number of posts: 0')
      click_on 'Amy'
      expect(page).to have_no_content('Jerry')
    end
  end
end
