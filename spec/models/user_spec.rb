# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context "新規登録ができる時" do
    it "name, email, passwordが正しく入力されれば有効" do
      expect(@user).to be_valid
    end

    it "nameが1〜20文字であれば有効" do
      @user.name = Faker::Internet.username(specifier: 1..20)
      expect(@user).to be_valid
    end

    it "passwordが1〜72文字、半角英数字、password_confirmationと一致していれば有効" do
      @user.password = Faker::Internet.password(min_length: 1, max_length: 72)
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end
  end

  describe "新規登録できない時" do
    context "nameについて" do
      it "nameが空であるとエラーが発生" do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it "nameが20文字より多いとエラーが発生" do
        @user.name = Faker::Name.initials(number: 21)
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は20文字以内で入力してください")
      end
    end

    context "emailについて" do
      it "emailが空であるとエラーが発生" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it "emailが255文字より多いとエラーが発生" do
        @user.email = Faker::Internet.email(name: "a" * 255)
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは255文字以内で入力してください")
      end

      it "emailに'＠'がないとエラーが発生" do
        @user.email = "aaaaa.aa"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
      it "emailの'＠'の後に'.'がないとエラーが発生" do
        @user.email = "aaaaa@aa"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
    end

    context "passwordについて" do
      it "passwordが空だとエラーが発生" do
        @user.password = nil
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "passwordが72文字よりも多いとエラーが発生" do
        @user.password = Faker::Internet.password(min_length: 73)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは72文字以内で入力してください")
      end
      it "passwordとpassword_confirmationが一致しないとエラーが発生" do
        @user.password = Faker::Internet.password
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
    end
  end
end
