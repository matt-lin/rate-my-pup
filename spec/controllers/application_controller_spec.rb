require 'spec_helper'

describe ApplicationController do
  describe "deleting pup from session" do
    controller do
      before_filter :delete_pup_from_session
      def main
        render :nothing => true
      end
    end
    before do
      routes.draw {get "main" => "anonymous#main"}
    end
    it "should delete the pup from the hash" do
      session[:pup] = true
      get :main
      session[:pup].should == nil
    end
    it "shouldn't delete a non-existent pup" do
      session.delete(:nil)
      get :main
      session[:pup].should == nil
    end
  end
end
