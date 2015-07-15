require 'rails_helper'

describe LinksController, :type => :controller do
  
  describe 'POST create' do
    it "creates new link" do
      expect{ post :create, link: { original_link: "http://railscasts.com/episodes/275-how-i-test" } }.to change(Link, :count).by(1)
    end

    it 'sends wrong parameter for creating new link' do
      expect{ post :create, link: { original_link: "" } }.to_not change(Link, :count)
    end
  end

end




