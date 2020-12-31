require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = FactoryBot.build(:relationship)
  end
  
  context "フォローできる時" do
    it "まだフォローしていない時有効" do
      expect(@relationship).to be_valid
    end
  end

  context "アソシエーションについて" do
    it "フォローするuserがいないとエラーが発生" do
      @relationship.user = nil
      @relationship.valid?
      expect(@relationship.errors.full_messages).to include("Userを入力してください")
    end

    it "フォロー対象のuserがいないとエラーが発生" do
      @relationship.follow = nil
      @relationship.valid?
      expect(@relationship.errors.full_messages).to include("Followを入力してください")
    end

    it '既にフォローしたuserを再度フォローするとエラーが発生' do
      @relationship.save
      @relationship_repeat = FactoryBot.build(:relationship)
      @relationship_repeat.user = @relationship.user
      @relationship_repeat.follow = @relationship.follow
      @relationship_repeat.valid?
      expect(@relationship_repeat.errors.full_messages).to include("Followはすでに存在します")
    end
  end
end
