# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @notification = FactoryBot.build(:notification)
  end

  context "通知が問題なく実行できる時" do
    it "全て値が正常であれば、有効" do
      expect(@notification).to be_valid
    end
  end

  context "通知でエラーが発生する時" do
    it "通知対象のuserがいないとエラーが発生" do
      @notification.visited = nil
      @notification.valid?
      expect(@notification.errors.full_messages).to include("Visitedを入力してください")
    end
  end
end
