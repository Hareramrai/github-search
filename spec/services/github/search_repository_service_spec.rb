# frozen_string_literal: true

require "rails_helper"

RSpec.describe Github::SearchRepositoryService do
  subject { described_class.call(query: query) }

  describe ".call" do
    context "when github call is successfull" do
      let(:query) { "rails" }

      include_context "when github search api successfull"

      it "returns list of repository" do
        expect(subject).to eq(github_search_response.with_indifferent_access)
      end
    end

    context "when github call is failed" do
      let(:query) { "" }

      include_context "when github search api failed"

      it "raise exception when any failure" do
        expect { subject }
          .to raise_error(Github::GithubService::SearchError)
      end
    end
  end
end
