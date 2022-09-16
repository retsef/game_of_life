# frozen_string_literal: true

class Form::LabelComponent < ViewComponent::Form::LabelComponent
  def html_class
    'block text-sm font-medium text-gray-700 field-label'
  end
end
