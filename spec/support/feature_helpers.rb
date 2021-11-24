module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within '.actions' do
      click_on 'Log in'
    end
    expect(page).to have_content 'Signed in successfully.'
  end
end
