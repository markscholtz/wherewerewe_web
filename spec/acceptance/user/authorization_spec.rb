require "spec_helper"

feature "Authorization feature", %q{
  As the system
  In order to protect resources from unauthorized access
  I want to restrict access based on user privileges
} do

  let!(:user) { FactoryGirl.create(:user) }

  context "An unauthorized user" do
    scenario "Accessing the watch page" do
      visit progressions_path
      expect(current_path).to eq root_path
      expect(page).to have_content "Please log in"
    end
  end
end
