require 'rails_helper'

describe 'show book by title ', type: :feature do
  let(:user) { create(:user) }
  let!(:book1) { create(:book) }
  let!(:book2) { create(:book) }
  let!(:book3) { create(:book) }

  describe 'GET #search' do
    before do
      user = FactoryBot.create(:user)
      login_as(user)
      visit root_path
      sleep(10)
    end

    it 'returns books matching the search query' do
      fill_in 'query', with: book1.title

      expect(page).to have_content(book1.title)
      expect(page).not_to have_content(book2.title)
      expect(page).not_to have_content(book3.title)
    end
  end
end
