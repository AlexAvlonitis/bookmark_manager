require 'spec_helper'

feature "viewing bookmarks" do
  scenario "accesing a list of links" do
    Link.create(title: 'title',link: 'link')
    vist '/links'
    expect(page).to have_content('title')
    expect(page).to have_content('link')
  end
end