require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "bootstrap class" do
    it "returns the correct class according to flash type" do
      ApplicationHelper.bootstrap_class_for(:success).should eq("alert-success")
      bootstrap_class_for(:error).should eq("alert-error")
      bootstrap_class_for(:alert).should eq("alert-block")
      bootstrap_class_for(:notice).should eq("alert-info")
      bootstrap_class_for(:modal).should eq("modal")
    end
  end
end