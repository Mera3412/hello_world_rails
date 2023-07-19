require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "accountを指定しているとき" do
    it "ユーザーが作られる" do
      user = build(:user)
      # 元々こう( user = FactoryBot.build(:user))
      expect(user).to be_valid
    end
  end

  context "accountを指定していないとき" do
    it "ユーザー作成に失敗する" do
      user = FactoryBot.build(:user,account: nil)
      # 元々こう(user = FactoryBot.build(:user,account: nil))
      expect(user).to be_invalid
      # expext(user.errors.details[:account][0][:error]).to eq :blank
    end
  end

  # context "まだ同じ名前のaccountが存在しないとき" do
  #     it "ユーザーが作られる" do
  #       user = User.new(name: "foo", account: "foo", email: "foo@example.com")
  #       expect(user).to be_valid
  #     end
  #   end

  context "すでに同じ名前のaccountが存在したとき" do
    it "ユーザー作成に失敗する" do
      create(:user, account: "foo")
      user = build(:user, account: "foo")

      expect(user).to be_invalid
      # expect(user.errors.details[:account][0][error]).to eq :taken
    end
  end


 end
