feature 'Login' do
  scenario 'A user can login and see a welcome message' do
    signup
    login
    expect(current_path).to eq('/links')
    expect(page).to have_content('Welcome Alex')
  end

  scenario 'When a user logs in with incorrect password gives login screen again' do
    signup
    login(password: 'incorrect_password')
    expect(current_path).to eq('/users/login')
  end
end
