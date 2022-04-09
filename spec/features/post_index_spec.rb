require 'rails_helper'

RSpec.feature 'post index page', js: true, type: :feature do
  background do
    visit user_session_path

    image = 'https://images.unsplash.com/photo-1648974299612-679d6fb46816?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
    bio = 'Teacher from Mexico.'
    @jake = User.create!(name: 'Jake', photo: image, bio: bio, posts_counter: 0, email: 'jake@mail.com',
                         password: 'jake123')
    fill_in 'Email', with: 'jake@mail.com'
    fill_in 'Password', with: 'jake123'
    click_button 'Log in'

    @post = @jake.posts.create!(title: 'programmer', text: 'Iam Programmer I have life', likes_counter: 0,
                                comments_counter: 0)
    @jake.posts.create!(title: 'Sky', text: 'Why is the sky blue?', likes_counter: 0, comments_counter: 0)

    fin = User.create!(name: 'fin', photo: image, bio: bio, posts_counter: 0, email: 'fin@mail.com',
                       password: 'fin1234')
    fin.comments.create!(text: 'hi jake.', post: @post)
    fin.comments.create!(text: 'hi jake!', post: @post)
    visit user_posts_path(@jake)
  end

  it "can see the user's profile picture." do
    expect(page).to have_content 'programmer'
  end

  it 'can see the user\'s username.' do
    expect(page).to have_content 'Jake'
  end

  it 'can see the number of posts the user has written' do
    expect(page).to have_content 'Comments: 2'
  end

  it 'can see a post\'s title.' do
    expect(page).to have_content 'Likes: 0'
  end

  it 'can see some of the post\'s body.' do
    expect(page).to have_content 'Iam Programmer I have life'
  end

  it 'can see the first comments on a post' do
    expect(page).to have_content 'hi jake'
  end

  it 'can see how many comments a post has.' do
    expect(page).to have_content 'hi jake.'
    expect(page).to have_content 'hi jake!'
  end

  it 'can see how many likes a post has.' do
    expect(page).to have_content 'hi jake'
    expect(page).to have_content 'hi jake!'
  end

  it 'can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content 'hi jake'
    expect(page).to have_content 'hi jake!'
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    expect(page).to have_content 'hi jake'
    expect(page).to have_content 'hi jake!'
  end
end
