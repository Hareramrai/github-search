# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search. Repositories', type: :feature do
  it 'allows uses to search github repo' do
    pending 'due to capybara-webkit setup issues!'
    visit root_url

    expect(page).to have_selector('input#search-field')

    fill_in 'search-field', with: 'rails'

    wait_for_ajax
    reload_page

    expect(page).to have_css('.full_name', text: 'rails / ruby')
  end
end
