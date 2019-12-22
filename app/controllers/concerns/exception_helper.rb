# frozen_string_literal: true

module ExceptionHelper
  extend ActiveSupport::Concern

  included do
    rescue_from GithubService::SearchError, with: :github_api_failure

    private

    def github_api_failure(exception)
      render json: { error: exception.message }, status: :bad_request
    end
  end
end
