feature 'User and password' do
  scenario 'sign up and create password' do
    sign_up
    expect(current_path).to eq '/links'
    expect(page).to have_content "Welcome sam@sam.sam"
    expect(User.count).to eq 1
  end

  scenario 'sign in with two different passwords' do
    visit '/'
    fill_in 'email', with: "sam@sam.sam"
    fill_in 'password', with: "sam1"
    fill_in 'confirm_password', with: "sam2"
    click_button "Sign in"
    expect(User.count).to eq 0
    expect(page).to have_content "Your passwords don't match"
  end

  scenario 'create user without email' do
    User.create(email: nil)
    expect(User.count).to eq 0
  end

  scenario 'create user with invalid email' do
    User.create(email:  'squigglewiggle')
    expect(User.count).to eq 0
  end

  scenario 'try to sign up whe already have account' do
    sign_up
    visit '/'
    fill_in 'email', with: "sam@sam.sam"
    fill_in 'password', with: "sam2"
    fill_in 'confirm_password', with: "sam2"
    click_button "Sign in"
    expect(User.count).to eq 1
    expect(page).to have_content "This email address is already registered"
  end


end
