require 'rails_helper'

describe Link, type: :model do
  
  context "is invalid when" do

    it "original_link == nil" do
      link = build(:link, original_link: nil)
      link.valid?
      expect(link.errors[:original_link]).to include("can't be blank")
    end

    it "original_link == simple string" do
      link = build(:link, original_link: 'aaa')
      link.valid?
      expect(link.errors[:original_link]).to include("can't be blank")
    end

  end

  context "is valid when" do

    it "original_link == domain name" do
      link = build(:link, original_link: 'mail.ru')
      expect{link.save}.to change{Link.count}.by(1)
    end

    it "original_link == domain + path to page" do
      link = build(:link, original_link: 'http://www.relishapp.com/rspec/rspec-expectations/docs')
      expect{link.save}.to change{Link.count}.by(1)
    end

  end

  context "when has domain w/o web protocol" do

    it "will get 'http://' " do
      link = create(:link, original_link: "ya.ru")
      expect(link.original_link).to start_with("http://")
    end

  end

  context "when has domain with web protocol" do

    it "will not change it" do
      link = create(:link, original_link: "https://github.com")
      expect(link.original_link).to_not eq("http://github.com")
    end

  end

end