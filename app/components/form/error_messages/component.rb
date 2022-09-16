class Form::ErrorMessages::Component < ApplicationComponent
  attr_reader :resource

  def initialize(resource:)
    @resource = resource
  end

  def error_messages
    resource.errors.full_messages
  end

  def errors_count
    resource.errors.size
  end

  def resource_name
    resource.class.model_name.human.downcase
  end

  def render?
    return false unless resource.present?

    resource.errors.any?
  end
end