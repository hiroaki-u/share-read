require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  context "投稿できる時" do
    it "contentが正しければ有効" do
      expect(@comment).to be_valid
    end
    it "contentが1文字であれば有効" do
      @comment.content = Faker::String.random(length: 1)
      expect(@comment).to be_valid
    end
    it "contentが255文字であれば有効" do
      @comment.content = Faker::String.random(length: 255)
      expect(@comment).to be_valid
    end
  end

  describe "投稿できない時" do
    context "contentについて" do
      it "contentがnilである時エラーが発生" do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end

      it "contentが1200文字以上である時エラーが発生" do
        @comment.content = Faker::String.random(length: 256)
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントは255文字以内で入力してください")
      end
    end

    context "アソシエーションについて" do
      it "userが紐付いていないと保存できない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end

      it "reviewが紐付いていないと保存できない" do
        @comment.review = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Reviewを入力してください")
      end
    end
  end
end
