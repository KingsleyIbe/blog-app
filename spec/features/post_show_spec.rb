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

    post = @jake.posts.create!(title: 'programmer', text: 'Iam Programmer I have life', likes_counter: 0,
                               comments_counter: 0)

    lucy = User.create!(name: 'Lucy', photo: image, bio: bio, posts_counter: 0, email: 'lucy@mail.com',
                        password: 'r89eudhbgvb')
    lucy.comments.create!(text: 'haha.', post: post)
    lucy.comments.create!(text: 'hola', post: post)
    visit user_post_path(@jake, post)
  end

  it "see the post's title" do
    expect(page).to have_content 'programmer'
  end

  it 'can see who wrote the post.' do
    expect(page).to have_content 'Jake'
  end

  it 'can see how many comments it has.' do
    expect(page).to have_content 'Comments: 2'
  end

  it 'can see how many likes it has.' do
    expect(page).to have_content 'Likes: 0'
  end

  it 'can see the post body.' do
    expect(page).to have_content 'Iam Programmer I have life'
  end

  it 'can see the username of each commentor.' do
    expect(page).to have_content 'Lucy'
  end

  it 'can see the comment each commentor left.' do
    expect(page).to have_content 'haha.'
    expect(page).to have_content 'hola'
  end
end
