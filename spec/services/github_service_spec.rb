# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  context '#search_repositories' do
    include_context 'when github api called'

    it 'should return repositories' do
      expect(GithubService.search_repositories('rails'))
        .to eq(github_search_response.with_indifferent_access)
    end

    it 'should raise exception when any failure' do
      stub_request(:get, GithubService::BASE_URL)
        .with(query: Rails.application.secrets.github.merge(query_params))
        .to_return(
          status: [422],
          headers: { 'Content-Type' => 'application/json' },
          body: {
            message: 'Validation Failed',
            errors: [
              {
                resource: 'Repository',
                field: 'query',
                code: 'missing_field'
              }
            ]
          }.to_json
        )

      expect { GithubService.search_repositories('rails') }
        .to raise_error(GithubService::SearchError)
    end
  end
end
