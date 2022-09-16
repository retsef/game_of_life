Rails.configuration.to_prepare do
  # Rails.application.config.view_component.render_monkey_patch_enabled = false # defaults to true

  ActiveSupport.on_load(:action_view) do
    require 'view_component/render_component_helper'
    include ViewComponent::RenderComponentHelper

    ActionView::Base.field_error_proc = proc { |html_tag, _instance| html_tag.html_safe }
  end

  ActiveSupport.on_load(:action_controller) do
    require 'view_component/rendering_component_helper'
    require 'view_component/render_component_to_string_helper'

    include ViewComponent::RenderingComponentHelper
    include ViewComponent::RenderComponentToStringHelper
  end
end
