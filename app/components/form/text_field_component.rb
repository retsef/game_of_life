# frozen_string_literal: true

class Form::TextFieldComponent < ViewComponent::Form::TextFieldComponent
  self.tag_klass = ActionView::Helpers::Tags::TextField

  def html_class
    default_classes = 'block w-full sm:text-sm rounded-md'
    normal_classes = 'border-gray-300 focus:ring-primary-500 focus:border-primary-500'
    error_classes = 'pr-10 border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500'

    "#{default_classes} #{method_errors? ? error_classes : normal_classes}"
  end
end
