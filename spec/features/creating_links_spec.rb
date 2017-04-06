feature "user can add links" do
  before do
    sign_up
  end

  scenario "save links to database" do
    create_link
    expect(current_path).to eq '/links'

    within "ul#links" do
      expect(page).to have_content("icanhazburgers")
    end
  end

  scenario 'create a tag when saving link' do
    create_link
    expect(current_path).to eq '/links'
    link = Link.first
    expect(link.tags.map(&:name)).to include("animal")
  end

  scenario 'create more than one tag' do
    visit '/links/new'
    fill_in :title, with: "icanhazburgers"
    fill_in :url, with: "http://icanhas.cheezburger.com/cats"
    fill_in :tags, with: "animal, feed me"
    click_button "Save link"
    link = Link.first
    # require 'pry'; binding.pry
    expect(link.tags.map(&:name)).to include("animal")
    expect(link.tags.map(&:name)).to include("feed me")
  end

end
