require 'rails_helper'

describe 'Loan a book', type: :feature do
  let(:user) { create(:user) }
  let!(:book) { create(:book) }

  context 'when user is login' do
    before do
      user = FactoryBot.create(:user)
      login_as(user)
      visit root_path
      sleep(10)
    end

    it 'displays successful message' do
      click_button 'Loan'
      expect(page).to have_content('Book Loan was successfully created.')
    end
  end
end
