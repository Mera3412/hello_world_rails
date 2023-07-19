require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject{get(users_path)}# テストで確認したいこと
    before{create_list(:user,3)}# 事前に行う処理を書く
    it "ユーザーの一覧が取得できる" do
      subject

      # res = JSON.parse(respone.body)
      # expect(res.length).to eq 3
      # expect(response).tohave_http_status(200)
      # expect(response.status).to eq 200
    end
  end

  describe "GET /users/:id" do
    subject{get(users_path(user_id))}
    context "指定したIDのユーザーが存在するとき"do
    let(:user_id){user.id}# 呼び出された時に実行される
    let(:user){create(:user)}# 呼び出された時に実行される
      it "任意のユーザーのレコードが取得できる" do
        subject

        # res = JSON,parse(response.body)
        # expect(res["name"]).to eq use.name
        # expect(res["account"]).to eq use.account
        # expect(res["email"]).to eq use.email

        # expect(response).tohave_http_status(200)
      end
    end
    context "指定したIDのユーザーが存在しないとき"do
    let(:user_id){10000}
      it "ユーザーが見つからない" do
        subject
        # expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /users" do
    subject{post(users_path, params: params)}
    context "適切なパラメーターを送信したとき"do
    let(:params)do
      {user: attributes_for(:user)}
    end
      it "ユーザーのレコードを作成できる" do
        expect{subject}.to change{User.count}.by(1)
        res = JSON.parse(response.body)
        expect(res["name"]).to eq params[:user][:name]
        expect(res["account"]).to eq params[:user][:account]
        expect(res["email"]).to eq params[:user][:email]

        expect(response).tohave_http_status(200)
      end
    end

  context"不適切なパラメーターを送信したとき"do
  let(:params)do
      {user: attributes_for(:user)}
    end
    it "ユーザーのレコードの作成に失敗する"do
      expect {subject}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

  describe "PATCH(PUT) /users/:id" do
    subject {PATCH(users_path(user_id),params: params)}

    let(:params) do
      {user:{name: Faker::Name.name, created_at: 1.day.ago}}
    end
    let(:user_id){user.id}
    let(:user){create(:user)}
    it "任意のユーザーのレコードを更新できる" do
      expect{subject}.to change{user.reload.name}.from(user.name).to(params[:user][:name]) &
                         not_change{user.reload.account} &
                         not_change{user.reload.email} &
                         not_change{user.reload.created_at}
    end
  end

  describe "DELETE /users/:id" do
    subject {delete(users_path(user_id))}
    let(:user_id){user.id}
    let!(:user) { create(:user) }

    it "任意のユーザーのレコードを削除できる" do
      expect { subject }.to chenge {User.count}.by(1a)
    end
  end

end
