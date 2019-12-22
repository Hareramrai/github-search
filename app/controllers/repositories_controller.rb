# frozen_string_literal: true

class RepositoriesController < ApplicationController
  def search
    render json: GithubService.search_repositories(params[:q])
  end
end
