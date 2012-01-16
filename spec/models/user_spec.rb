require 'spec_helper'

describe User do
  it { should have_many :reports }

  describe "#admin?" do
    subject { User.first.admin? }
    context "true" do
      before do
        create(:user, :role => 'admin')
      end
      it { should be_true }
    end
    context "false" do
      before do
        create(:user, :role => 'moderator')
      end
      it { should be_false }
    end
  end

  describe "#moderator?" do
    subject { User.first.moderator? }
    context "true" do
      before do
        create(:user, :role => 'moderator')
      end
      it { should be_true }
    end
    context "false" do
      before do
        create(:user)
      end
      it { should be_false }
    end
  end
end
