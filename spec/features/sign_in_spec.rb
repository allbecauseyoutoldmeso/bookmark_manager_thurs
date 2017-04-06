feature 'signing in' do

  scenario 'signing back in as registered user' do
    sign_up
    visit '/sign_in'
    fill_in 'email', with: 'sam@sam.sam'
    fill_in 'password', with: 'sam1'
    click_button 'Sign in'
    expect(page).to have_content 'Welcome sam@sam.sam'
  end
end
