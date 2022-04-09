require 'rails_helper'

RSpec.describe 'user#Show', type: :feature do
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
      @post1 = Post.create(title: 'First Post', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post2 = Post.create(title: 'Second Post', text: 'This is my second post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post3 = Post.create(title: 'Third Post', text: 'This is my third post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      @post4 = Post.create(title: 'Fourth Post', text: 'This is my fourth post', comments_counter: 0, likes_counter: 0,
                           author: @user1)
      visit user_path(@user1.id)
    end
    it "show user's profile picture" do
      all('img').each do |i|
        expect(i[:src]).to eq('/assets/image1-f893171ac7386418fbe290a681d9c12a7fecc5946afd70dccdb96626edfc7694.jpg')
      end
    end

    it "show user's name" do
      expect(page).to have_content 'Amy'
    end

    it 'show number of posts per user' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it "show user's bio." do
      expect(page).to have_content('bio')
    end

    it "show user's first 3 posts." do
      expect(page).to have_content 'This is my fourth post'
      expect(page).to have_content 'This is my third post'
      expect(page).to have_content 'This is my second post'
    end

    it "show button that lets me view all of a user's posts." do
      expect(page).to have_link('See all posts')
    end

    it "click post and redirect to that post's show page." do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user1)
    end

    it "click see all posts and redirects to user's post's index page." do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user1)
    end
  end
end
