require 'rails_helper'

describe "static_pages/main" do

  it 'has a description on the main page' do
    assign(:link, Link.new)
    render
    expect(rendered).to have_content("Ссылка будет действительна в течение 7 дней")
  end

end
