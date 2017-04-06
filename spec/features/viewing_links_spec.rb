feature 'viewing links' do
  before do
    sign_up
  end

  scenario 'there is a list of links on the homepage' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy') # datamapper syntax
    visit '/links' # Visit the links URL
    expect(page.status_code).to eq 200 # Sanity check to ensure can load the page.

    within 'ul#links' do # Unordered list, link.
      expect(page).to have_content('Makers Academy')
    end
  end
end
