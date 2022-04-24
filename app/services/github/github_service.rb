# frozen_string_literal: true

class Github::GithubService < ApplicationService
  class SearchError < StandardError; end
  BASE_URL = "https://api.github.com"

  private

    def request(resource, params, method = :get)
      response = Typhoeus::Request.new(
        "#{BASE_URL}/#{resource}",
        method: method,
        params: params.compact,
        headers: headers
      ).run

      raise SearchError unless response.success?

      MultiJson.load(response.body)
    end

    def headers
      { Authorization: "Bearer #{access_token}" }
    end

    def access_token
      Rails.application.secrets.github_access_token
    end
end
