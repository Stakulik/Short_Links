require 'rails_helper'

describe "static_pages/main" do

  it 'has a greeting on the main page' do
    assign(:link, Link.new)
    render
    expect(rendered).to have_content("Hello")
  end

end
