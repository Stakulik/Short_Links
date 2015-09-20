require 'rails_helper'

describe LinksController, :type => :controller do
  
  context 'POST create' do

    it "redirects to '/' when a new link is saved" do
      post :create, link: attributes_for(:link, original_link: "http://railscasts.com/episodes/")
      expect(response).to redirect_to(root_path)
    end

    it "renders a 'main' template when a new link has a wrong parameter (original_link = nil)" do
      post :create, link: attributes_for(:link, original_link: nil)
      expect(response).to render_template(:main)
    end

    it "renders a 'main' template when a new link has a wrong parameter (original_link = 'ololo')" do
      post :create, link: attributes_for(:link, original_link: "ololo")
      expect(response).to render_template(:main)
    end

  end

  context 'GET router' do

    it "redirects to an original link" do
      link = create(:link)
      get :router, attributes_for(:link, alias_link: link.alias_link)
      expect(response).to redirect_to("http://www.yandex.ru/")
    end

    it "redirects to a root path while a required alias_link does not exist, but has length = 5 symbols" do
      get :router, attributes_for(:link, alias_link: "DDDDD") 
      expect(response).to redirect_to root_path 
    end

    it "redirects to a root path while a required alias_link has length != 5 symbols" do
      get :router, attributes_for(:link, alias_link: "ok")
      expect(response).to redirect_to root_path
    end

  end

end