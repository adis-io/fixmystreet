require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ReportsHelper. For example:
#
# describe ReportsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ReportsHelper do
  describe "#display_waiting_moderation_item?" do
    subject { display_waiting_moderation_item? }
    before do
    end
    context "current user is admin" do
      before do
        user = create(:user, role: 'admin')
        should_receive(:current_user).twice.and_return(user)
      end
      it { should be_true }
    end
    context "current user is moderator" do
      before do
        user = create(:user, role: 'moderator')
        should_receive(:current_user).exactly(3).times.and_return(user)
      end
      it { should be_true }
    end
    context "regular user has reports" do
      before do
        user = create(:user)
        create(:report, user: user, state: :waiting_moderation)
        should_receive(:current_user).exactly(4).times.and_return(user)
      end
      it { should be_true }
    end

    context "false" do
      before do
        user = create(:user)
        should_receive(:current_user).exactly(4).times.and_return(user)
      end
      it { should be_false }
    end
  end
end
