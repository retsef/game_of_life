class Form::FileFieldComponent < ViewComponent::Form::FileFieldComponent
  self.tag_klass = ActionView::Helpers::Tags::FileField

  def html_class
    default_classes = 'block w-full sm:text-sm rounded-md cursor-pointer'
    normal_classes = 'border-gray-300 focus:ring-primary-500 focus:border-primary-500'
    error_classes = 'border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500'

    "#{default_classes} #{method_errors? ? error_classes : normal_classes}"
  end
end