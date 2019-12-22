# frozen_string_literal: true

class GithubService
  BASE_URL = 'https://api.github.com/search/repositories'

  class << self
    def search_repositories(query)
      query_params = {
        sort: 'stars',
        order: 'desc',
        type: 'Repositories',
        q: query
      }

      request(BASE_URL, query_params)
    end

    private

    def request(endpoint, params, method = :get)
      github_credentials = Rails.application.secrets.github

      response = Typhoeus::Request.new(
        endpoint,
        method: method,
        params: params.merge(github_credentials)
      ).run

      raise GithubService::SearchError unless response.success?

      MultiJson.load(response.body)
    end
  end

  class SearchError < StandardError; end
end
