# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Api::V1::JobsController", type: :request, swagger_doc: SWAGGER_V1_DOC do
  path "/repositories/" do
    get "List of repositories" do
      tags "Repositories API"

      consumes MIME_APPLICATION_JSON

      parameter name: :q, in: :query, type: :string

      response "200", "returns repositories when github request is succesfull" do
        let(:q) { "rails" }

        include_context "when github search api successfull"

        schema \
          type: :object,
          properties: {
            items: {
              type: :array,
              items: { "$ref" => "#/components/schemas/repository" },
            },
          }

        run_test! do
          expect(json_response(response).dig(:items, 0, :full_name)).to eq("rails/rails")
        end
      end

      response "400", "returns errors when github request is failed" do
        let(:q) { "" }

        include_context "when github search api failed"

        schema properties: { "$ref" => "#/components/schemas/error_object" }

        run_test! do
          expect(json_response(response)).to eq({ error: "Github::GithubService::SearchError" })
        end
      end
    end
  end
end
