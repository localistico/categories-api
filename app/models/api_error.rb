# Api Errors
class ApiError
  include ActiveModel::Serialization

  attr_accessor :id, :description
  ERRORS = {
    invalid_request: 400,
    unsupported_grant_type: 400,
    invalid_grant: 400,
    unauthorized: 401,
    not_found: 404,
    internal_error: 500
  }

  def initialize(id, description = nil)
    fail ArgumentError, "Unknown error id: #{id}" if ERRORS[id].nil?

    self.id = id
    self.description = description
  end

  def code
    ERRORS[id]
  end
end
