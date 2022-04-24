# frozen_string_literal: true

RSpec.shared_context "when github search api successfull", shared_context: :metadata do
  let(:github_search_response) do
    {
      status: "OK",
      total_count: 40,
      incomplete_results: false,
      items: [
        {
          id: 3_081_286,
          name: "rails",
          full_name: "rails/rails",
          owner: {
            id: 23_324,
            login: "dtrupenn",
            avatar_url: "https://avatars.githubusercontent.com/u/4223?s=200&v=4",
          },
          private: false,
          html_url: "https://github.com/dtrupenn/rails",
          description: "Ruby on Rails",
          stargazers_count: 1,
          watchers_count: 1,
          language: "Ruby",
          forks_count: 0,
        },
      ],
    }
  end

  let(:query_params) do
    {
      sort: "stars",
      order: "desc",
      type: "Repositories",
      q: "rails",
    }
  end

  before do
    stub_request(:get, "#{Github::GithubService::BASE_URL}/search/repositories")
      .with(query: query_params)
      .to_return(
        status: [200],
        headers: { "Content-Type" => "application/json" },
        body: github_search_response.to_json
      )
  end
end

RSpec.shared_context "when github search api failed", shared_context: :metadata do
  let(:query_params) do
    {
      sort: "stars",
      order: "desc",
      type: "Repositories",
      q: "",
    }
  end

  before do
    stub_request(:get, "#{Github::GithubService::BASE_URL}/search/repositories")
      .with(query: query_params)
      .to_return(
        status: [422],
        headers: { "Content-Type" => "application/json" },
        body: {
          message: "Validation Failed",
          errors: [
            {
              resource: "Repository",
              field: "query",
              code: "missing_field",
            },
          ],
        }.to_json
      )
  end
end
