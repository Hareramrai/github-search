# frozen_string_literal: true

require "rails_helper"

RSpec.describe "homes/index.html.haml", type: :view do
  it "renders input field for search" do
    render

    expect(rendered).to match(
      /<input class='form-control' id='search-field' type='text'>/
    )
  end
end
