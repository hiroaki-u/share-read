require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end
  
  context "お気に入り登録できる時" do
    it "まだお気に入り登録をしていない時有効" do
      expect(@favorite).to be_valid
    end
  end

  context "アソシエーションについて" do
    it "userがいないとエラーが発生" do
      @favorite.user = nil
      @favorite.valid?
      expect(@favorite.errors.full_messages).to include("Userを入力してください")
    end

    it "お気に入り対象のreviewがないとエラーが発生" do
      @favorite.review = nil
      @favorite.valid?
      expect(@favorite.errors.full_messages).to include("Reviewを入力してください")
    end

    it '既にお気に入り登録したreviewをお気に入り登録するとエラーが発生' do
      @favorite.save
      @favorite_repeat = FactoryBot.build(:favorite)
      @favorite_repeat.user = @favorite.user
      @favorite_repeat.review = @favorite.review
      @favorite_repeat.valid?
      expect(@favorite_repeat.errors.full_messages).to include("Reviewはすでに存在します")
    end
  end
end
