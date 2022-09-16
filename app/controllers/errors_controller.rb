class ErrorsController < ApplicationController
  protect_from_forgery with: :null_session
  layout 'errors'

  def not_found
    render status: :not_found
  end

  def unprocessable
    render status: :unprocessable_entity
  end

  def internal_server_error
    render status: :internal_server_error
  end

  def service_unavailable
    render status: :service_unavailable
  end
end
