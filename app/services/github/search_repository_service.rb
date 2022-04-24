# frozen_string_literal: true

class Github::SearchRepositoryService < Github::GithubService
  def initialize(query:)
    @query = query
  end

  def call
    query_params = {
      sort: "stars",
      order: "desc",
      type: "Repositories",
      q: query,
    }

    request("search/repositories", query_params)
  end

  private

    attr_reader :query
end
