# frozen_string_literal: true

class Api::V1::RepositoriesController < Api::BaseController
  # GET /repositories?q=:key
  def index
    render json: Github::SearchRepositoryService.call(query: params[:q])
  end
end
