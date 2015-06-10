require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do
    visit "/television_shows/new"
    fill_in("Title", with: "Veep")
    fill_in("Network", with: "HBO")
    find(:xpath, '//input[@id="starting_year"]').set 2012
    select("Comedy", from: "Genre")
    fill_in("Synopsis", with: "Veep is an American HBO political comedy
                              television series, starring Julia Louis-Dreyfus,
                              set in the office of Selina Meyer, a fictional
                              Vice President, and subsequent President, of the
                              United States.")
    click_button("Add TV Show")

    expect(page).to have_content("TV Shows")
    expect(page).to have_content("Veep")

  end

  scenario "fail to add a show with invalid information" do
    visit "/television_shows/new"
    fill_in("Title", with: "Orange is the New Black")
    fill_in("Network", with: "Netflix")
    find(:xpath, '//input[@id="starting_year"]').set 1875
    select("Drama", from: "Genre")
    fill_in("Synopsis", with: "Orange is the New Black is based on Piper
                               Kerman's memoir, Orange Is the New Black: My Year
                               in a Women's Prison, about her experiences in prison.")
    click_button("Add TV Show")

    expect(page).to have_content("Invalid Entry")
  end

end
