feature 'Password recovery' do

  before do
    signup
    click_button('logout')
    visit('/users/login')
    click_link('Forgot password')
    fill_in("email", with: 'alex@xela.com')
    expect(current_path).to eq '/users/reset-password'
    click_button("reset")
  end

  scenario 'A user can request for a password recovery' do
    expect(current_path).to eq '/users/login'
    expect(page).to have_content('Your password has been sent')
  end

  scenario 'A user enters the sent token to reset his password' do
    visit('/users/token')
    token = User.first.password_token
    fill_in("token", with: token)
    click_button("Submit")
    expect(current_path).to eq '/users/new-password'
    expect(page).to have_content('Reset your password')
  end
end
