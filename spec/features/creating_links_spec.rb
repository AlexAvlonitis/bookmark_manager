require 'spec_helper'


feature "submitting links" do
	scenario "adds new url and title" do
		visit '/links/new'
		fill_in("title", with: "Makers")
		fill_in("url", with: "www.makersacademy.com")
		click_button "Submit"
		expect(page).to have_content("Makers")
		expect(page).to have_content("www.makersacademy.com")
	end
end