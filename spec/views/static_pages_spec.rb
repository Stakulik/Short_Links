require 'rails_helper'

describe "static_pages/main" do

  it 'has a greeting on the main page' do
    assign(:link, Link.new)
    render
    expect(rendered).to have_content("Hello")
  end

end

describe "static_pages/about" do

  it 'has a header on the about page' do
    render
    expect(response).to have_content('About project')
  end

end