require 'rails_helper'

RSpec.describe Bookcase, type: :model do
  before do
    @bookcase = FactoryBot.build(:bookcase)
  end
  
  context "本棚登録できる時" do
    it "まだ本棚登録していない時有効" do
      expect(@bookcase).to be_valid
    end
  end

  context "アソシエーションについて" do
    it "userがいないとエラーが発生" do
      @bookcase.user = nil
      @bookcase.valid?
      expect(@bookcase.errors.full_messages).to include("Userを入力してください")
    end

    it "bookがないとエラーが発生" do
      @bookcase.book = nil
      @bookcase.valid?
      expect(@bookcase.errors.full_messages).to include("Bookを入力してください")
    end

    it '既に本棚登録したbookを本棚登録するとエラーが発生' do
      @bookcase.save
      @bookcase_repeat = FactoryBot.build(:bookcase)
      @bookcase_repeat.user = @bookcase.user
      @bookcase_repeat.book = @bookcase.book
      @bookcase_repeat.valid?
      expect(@bookcase_repeat.errors.full_messages).to include("Bookはすでに存在します")
    end
  end
end
