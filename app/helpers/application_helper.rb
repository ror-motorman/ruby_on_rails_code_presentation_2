module ApplicationHelper
  def path_to_js_for_current_page
    current_js_path = "pages/#{controller_name}/#{action_name}"
    return current_js_path if Rails.application.assets.resolve(current_js_path).present?

    js_path = "pages/#{controller_name}"
    Rails.application.assets.resolve(js_path).blank? ? '' : js_path
  end

  def title
    t("titles.#{controller_name}")
  end

  def flash_messages
    flash.each do |type, message|
      message_class = message_classes[type.to_sym] || type.to_s
      concat(
        content_tag(:div, message, class: "alert #{message_class} fade in") do
          concat content_tag(:button, '×', class: 'close', data: { dismiss: 'alert' })
          concat message
        end
      )
    end

    nil
  end

  def active_class_for(expected_controller_name)
    controller_name == expected_controller_name ? 'active' : ''
  end

  private

  def message_classes
    {
      notice: 'alert-info',
      success: 'alert-success',
      alert: 'alert-warning',
      error: 'alert-danger'
    }
  end
end
