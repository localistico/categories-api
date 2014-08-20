# ApiController defines the base methods and filters for the API endpoints
class ApiController < ActionController::Base
  respond_to :json

  before_filter :default_format_json

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # Set the default format to json unless another is specified in the url
  def default_format_json
    request.format = 'json' unless params[:format]
  end

  def record_not_found
    error = ApiError.new(:not_found, 'Could not find the resource')
    render json: error, status: error.code
  end
end
