require 'rails_helper'

describe StaticPagesController do

  it 'GET #main' do
    get :main
    expect(response).to render_template :main
  end

  it 'POST #main' do
    new_link = "http://railscasts.com/episodes/275-how-i-test"
    expect{ post :main, new_link }.to change(Link, :count).by(1)

  end

  it 'POST #main - !save' do
    new_link = "http://railscasts.com/episodes/ololo"
    expect{ post :main, new_link }.to_not change(Link, :count)
  end


  it 'GET #about' do
    get :about
    expect(response).to render_template :about
  end

end

