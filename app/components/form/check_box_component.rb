class Form::CheckBoxComponent < ViewComponent::Form::CheckBoxComponent
  self.tag_klass = ActionView::Helpers::Tags::CheckBox

  def html_class
    default_classes = 'h-4 w-4 rounded mr-2'
    normal_classes = 'border-gray-300 text-indigo-600 focus:ring-indigo-500'
    error_classes = 'border-red-300 text-red-900 focus:ring-red-500 focus:border-red-500'

    "#{default_classes} #{method_errors? ? error_classes : normal_classes}"
  end
end