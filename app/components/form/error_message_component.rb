# frozen_string_literal: true

class Form::ErrorMessageComponent < ViewComponent::Form::ErrorMessageComponent
  def html_class
    'invalid-feedback mt-2 text-sm text-red-600'
  end
end
