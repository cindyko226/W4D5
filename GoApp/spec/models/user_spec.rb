# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {User.create(username: "Tamir", password: "password")}

  describe 'validations' do 
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_length_of(:password).is_at_least(6)}
    it {should validate_presence_of(:session_token)}
    it {should validate_uniqueness_of(:session_token)}
    it {should validate_presence_of(:password_digest)}
  end 
  
  describe '::find_by_credentials' do 
    it 'returns a user' do
      expect(User.find_by_credentials(user.username, user.password)).to eq(user)
    end

    it 'returns nil if password is wrong' do 
      expect(User.find_by_credentials(user.username, password: "123")).to be_nil 
    end 
  end
end
