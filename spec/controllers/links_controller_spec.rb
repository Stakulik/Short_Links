require 'rails_helper'

describe LinksController, :type => :controller do
  
  describe 'POST create' do
    it "creates new link" do
      expect{ post :create, link: { original_link: "http://railscasts.com/episodes/275-how-i-test" } }.to change(Link, :count).by(1)
    end

    it 'sends wrong parameter original_link = nil' do
      expect{ post :create, link: { original_link: nil } }.to_not change(Link, :count)
    end

    it 'sends wrong parameter original_link = "olololo"' do
      expect{ post :create, link: { original_link: nil } }.to_not change(Link, :count)
    end

  end

  describe 'GET router' do
    it "redirects to original link" do
      Link.create(
        original_link: "http://google.ru",
        alias_link: "GOGLE"
      )

      expect( get :router, :alias_link => "GOGLE" ).to redirect_to("http://google.ru")
    end

    it "shows 'Данная ссылка не существует' while a required alias_link is not exist and has a length of 5 symbols" do
      expect( get :router, :alias_link => "DDDDD" ).to redirect_to root_path 
    end

    it "redirects to root_path while a required alias_link is not exist and alias_link.length != 5 symbols" do
      expect( get :router, :alias_link => "ok").to redirect_to root_path
    end
  end

end

