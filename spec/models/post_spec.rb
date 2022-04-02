# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Post model' do
    user = User.create(name: 'Kingsley', bio: 'This is bio')
    subject { Post.new(title: 'post title', text: 'post text', author_id: user) }
    before { subject.save }

    it 'check the title is not blank' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'tests if title more than 250chs to be invalid' do
      subject.title = 'more than 250 more than 250 more than 250 more
      than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more
      than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more than 250 '
      expect(subject).to_not be_valid
    end

    it 'check if comments counter is numeric' do
      subject.comments_counter = 'not-numeric'
      expect(subject).to_not be_valid
    end

    it 'check if likes counter is equal or greater than zero' do
      expect(subject.likes_counter).to be >= 0
    end

    it 'check if comments counter is equal or greater than zero' do
      expect(subject.comments_counter).to be >= 0
    end

    it 'loads only the recent 5 comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end
  end
end