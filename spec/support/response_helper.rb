# frozen_string_literal: true

module ResponseHelper
  def json_response
    JSON.parse(response.body)
  end
end
