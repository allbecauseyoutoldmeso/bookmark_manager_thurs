feature "user can view tags" do
  before do
    sign_up
  end

  scenario "filter by tag" do
    visit "/links/new"
    fill_in :title, with: "google"
    fill_in :url, with: "www.google.co.uk"
    fill_in :tags, with: "search"
    click_button "Save link"

    visit "/links/new"
    fill_in :title, with: "bubbles link"
    fill_in :url, with: "www.bubbles.co.uk"
    fill_in :tags, with: "bubbles"
    click_button "Save link"

    visit "/tags/bubbles"
    expect(page).not_to have_content "google"
    expect(page).to have_content "bubbles link"
  end

end
