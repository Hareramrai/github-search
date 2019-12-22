# frozen_string_literal: true

RSpec.shared_context 'when github api called', shared_context: :metadata do
  let(:github_search_response) do
    {
      status: 'OK',
      "total_count": 40,
      "incomplete_results": false,
      "items": [
        {
          "id": 3_081_286,
          "name": 'Tetris',
          "full_name": 'dtrupenn/Tetris',
          "owner": {
            "login": 'dtrupenn',
            "avatar_url": 'https://secure.gravatar.com/avatar/e7956084e'
          },
          "private": false,
          "html_url": 'https://github.com/dtrupenn/Tetris',
          "description": 'A C implementation of Tetris using Pennsim through LC4',
          "stargazers_count": 1,
          "watchers_count": 1,
          "language": 'Assembly',
          "forks_count": 0
        }
      ]
    }
  end

  let(:query_params) do
    {
      sort: 'stars',
      order: 'desc',
      type: 'Repositories',
      q: 'rails'
    }
  end

  before do
    stub_request(:get, GithubService::BASE_URL)
      .with(query: Rails.application.secrets.github.merge(query_params))
      .to_return(
        status: [200],
        headers: { 'Content-Type' => 'application/json' },
        body: github_search_response.to_json
      )
  end
end
