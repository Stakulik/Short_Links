require "rails_helper"


describe "Link management", :type => :feature do
  scenario "User creates a new short link" do
    visit '/'

    fill_in "link[original_link]", :with => "http://www.rubydoc.info/github/jnicklas/capybara/"
    click_button "Сократить"

    expect(page).to have_text("Ваша ссылка")
  end
    
  scenario "User can't send a not domain like a value" do
    visit '/'

    fill_in "link[original_link]", :with => "capybara"
    click_button "Сократить"

    expect(page).to have_text("Указана некорректная ссылка.")
  end

  it "[FIX]User is redirected to an original link when required an alias link" do
    link = Link.create(
      :original_link => 'https://mail.ru/',
      :alias_link => 'OPOPO'
    )
    
    visit '/OPOPO'
#    expect(current_path).to eq 'https://mail.ru/'
  end

  scenario "User is redirected to the main page while an alias link has length = 5 symbols" do
    visit '/DD3DD'

    expect(current_path).to eq '/'
    expect(page).to have_text("Данная ссылка не существует или была удалена.")
  end

  scenario "User is redirected to the main page while an alias has length != 5 symbols" do
    visit '/DDD4'

    expect(current_path).to eq '/'
  end

end