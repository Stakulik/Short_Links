require 'rails_helper'

describe 'StaticPages' do

  it 'has a greeting on the main page' do
    render :template => "static_pages/main.html.haml"
    expect(response).to have_content('Hello,')
  end

  it 'has a header on the about page' do
    render :template => "static_pages/about.html.haml"
    expect(response).to have_content('About project')
  end

end