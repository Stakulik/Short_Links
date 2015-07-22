require "rails_helper"

describe "Links creation", :type => :request do
  it "sends an original url and gets a short alias link" do
    get '/'
    expect(response).to render_template(:main)

    post '/', :link => { :original_link => "https://www.relishapp.com/rspec/" }
    expect(response).to redirect_to root_path
    follow_redirect!

    expect(response.body).to include("Ваша ссылка:")
  end

  it "has an error when sends a word instead of a domain and then gets a short link when sends the correct domain" do
    get '/'
    expect(response.body).to include("Ссылка будет действительна в течение 7 дней") 

    post '/', :link => { :original_link => "word" }
    expect(response).to render_template(:main)

    expect(response.body).to include("Указана некорректная ссылка")

    post '/', :link => { :original_link => "mail.ru" }
    expect(response).to redirect_to root_path
    follow_redirect!

    expect(response.body).to include("Ваша ссылка:")
  end

  it "follows a short link and gets an original url" do
    link = Link.create(
      :original_link => "http://rubylearning.com/satishtalim/ruby_regular_expressions.html",
      :alias_link => "RuoRa" )

    get '/RuoRa' 
    expect(response).to redirect_to link.original_link
  end

  it "redirects to the main page while require an alias link which does not exist and has length = 5 symbols" do
    get '/DDDDD'
    expect(response).to redirect_to root_path
    follow_redirect!
    expect(response.body).to include("Данная ссылка не существует или была удалена.")
  end

end