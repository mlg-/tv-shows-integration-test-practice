require "spec_helper"


feature "edit a tv show's information" do
#
# As a TV fanatic
# I want to edit an existing show
# So that I can correct any foolish mistakes
#
# Acceptance Criteria:
# [X] Editing a show provides a pre-populated form for each field.
# [X] Submitting the edit form will update a show if all validations pass.
# [X] The user is redirected to the details page for that show if successfully updated.
# [X] If the update fails any validations, re-display the form with the appropriate error messages.

  scenario 'editing a show provides a pre-populated form for each field' do
    friends = TelevisionShow.create!({
        title: "Friends", network: "NBC",
        starting_year: 1994, ending_year: 2004,
        genre: "Comedy",
        synopsis: "Follows the lives of six 20-something friends living in Manhattan."
      })

     friends_id = friends.id

     visit "/television_shows/#{friends_id}/edit"

     expect(page).to have_content("Edit Show")
     expect(page).to have_field('title', with:"#{friends.title}")
     expect(page).to have_selector("input[value='#{friends.starting_year}']")
     expect(page).to have_select('genre', selected: "#{friends.genre}")
     expect(page).to have_field('synopsis', with: "#{friends.synopsis}")

  end

  scenario 'submitting the edit form will update a show (if valid)' do
    friends = TelevisionShow.create!({
        title: "Friends", network: "NBC",
        starting_year: 1994, ending_year: 2004,
        genre: "Comedy",
        synopsis: "Follows the lives of six 20-something friends living in Manhattan."
      })

     friends_id = friends.id

     visit "/television_shows/#{friends_id}/edit"

     fill_in('synopsis', with: 'PIVOT!')
     click_button('Edit TV Show')

     expect(page).to have_content("#{friends.title}")
     expect(page).to have_content("PIVOT!")
     # unique text on show page
     expect(page).to have_content("Edit this show")

   end

   scenario 'the edit fails a validation' do
     friends = TelevisionShow.create!({
         title: "Friends", network: "NBC",
         starting_year: 1994, ending_year: 2004,
         genre: "Comedy",
         synopsis: "Follows the lives of six 20-something friends living in Manhattan."
       })

    friends_id = friends.id

    visit "/television_shows/#{friends.id}/edit"

    find(:xpath, '//input[@id="starting_year"]').set 1850
    click_button('Edit TV Show')

    expect(page).to have_content("Invalid Entry")
    expect(page).to have_content("Starting year must be greater than 1900")

  end

end
