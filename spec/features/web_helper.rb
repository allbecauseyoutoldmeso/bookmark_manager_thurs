def create_link
  visit '/links/new'
  fill_in :title, with: "icanhazburgers"
  fill_in :url, with: "http://icanhas.cheezburger.com/cats"
  fill_in :tags, with: "animal"
  click_button "Save link"
end

def sign_up
  visit '/'
  fill_in 'email', with: "sam@sam.sam"
  fill_in 'password', with: "sam1"
  fill_in 'confirm_password', with: "sam1"
  click_button "Sign in"
end
