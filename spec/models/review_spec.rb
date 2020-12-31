require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end
  
  context "投稿できる時" do
    it "status, contentが正しければ有効" do
      expect(@review).to be_valid
    end
    it "contentが1文字であれば有効" do
      @review.content = "a"
      expect(@review).to be_valid
    end
    it "contentが1200文字であれば有効" do
      @review.content = Faker::String.random(length: 1200)
      expect(@review).to be_valid
    end
  end

  describe "投稿できない時" do
    context "contentについて" do
      it "contentがnilである時エラーが発生" do
        @review.content = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("本のレビューを入力してください")
      end

      it "contentが1200文字以上である時エラーが発生" do
        @review.content = Faker::String.random(length: 1201)
        @review.valid?
        expect(@review.errors.full_messages).to include("本のレビューは1200文字以内で入力してください")
      end
    end

    context "アソシエーションについて" do
      it "userが紐付いていないと保存できない" do
        @review.user = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Userを入力してください")
      end

      it "bookが紐付いていないと保存できない" do
        @review.book = nil
        @review.valid?
        expect(@review.errors.full_messages).to include("Bookを入力してください")
      end
    end
  end
end
