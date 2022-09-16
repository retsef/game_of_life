module Notification
  class Alert::Component < BaseComponent
    attr_reader :flash_type, :flash_value

    def initialize(flash_type = :info, flash_value = nil)
      super

      @flash_type = flash_type
      @flash_value = flash_value
    end

    def icon
      case flash_type.to_sym
      when :notice then 'outline/check-circle.svg'
      when :warning then 'outline/exclamation-triangle.svg'
      when :error then 'outline/exclamation-circle.svg'
      else 'outline/check-circle.svg'
      end
    end

    def icon_class
      case flash_type.to_sym
      when :notice then 'text-green-400'
      when :warning then 'text-yellow-400'
      when :error then 'text-red-400'
      else 'text-sky-400'
      end
    end

    def render?
      flash_value.present?
    end
  end
end
