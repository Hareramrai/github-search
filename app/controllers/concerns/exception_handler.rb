# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Github::GithubService::SearchError, with: :github_api_failure

    def github_api_failure(exception)
      render json: { error: exception.message }, status: :bad_request
    end
  end
end
