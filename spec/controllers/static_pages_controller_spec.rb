require 'rails_helper'

describe StaticPagesController do

  it 'GET #main' do
    get :main
    expect(response).to render_template :main
  end

end

