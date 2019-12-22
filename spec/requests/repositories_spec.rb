require 'rails_helper'

RSpec.describe 'Repositories Controller', type: :request do
  describe 'GET /' do
    it 'returns status code 200' do
      get root_url
      expect(response).to have_http_status(200)
    end

    it 'renders index temple' do
      get root_url
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /repositories/search' do
    include_context 'when github api called'

    it 'renders index temple' do
      get search_repositories_url, params: { q: 'rails' },
                                   headers: { 'Content-Type': 'application/json' }

      expect(json_response)
        .to eq(github_search_response.with_indifferent_access)
    end
  end
end
