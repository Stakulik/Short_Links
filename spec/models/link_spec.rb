require 'rails_helper'

describe Link, type: :model do
  
  it "is invalid without an original_link" do
    link = build(:link, original_link: nil)
    link.valid?
    expect(link.errors[:original_link]).to include("can't be blank")
  end

  it "doesn't save a link with a non-unique alias_link parameter" do
    create(:link)
    link = build(:link, original_link: 'https://mail.ru/')
    link.valid?
    expect(link.errors[:alias_link]).to include("has already been taken")
  end

end