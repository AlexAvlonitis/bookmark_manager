feature 'viewing links' do
  scenario 'when a user visits the homepage it displays links' do
    link = Link.create(:title => "My Site", :url => "alex.avlonitis.me")
    tag = Tag.create(:tag => "test")
    link.tags << tag
    link.save
    visit('/links')
    expect(page).to have_content("My Site")
    expect(page).to have_content("alex.avlonitis.me")
  end
end