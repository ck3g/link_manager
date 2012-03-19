class DatepickerInput
  include Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      label_html <<
      builder.text_field(method, input_html_options)
    end
  end

  def input_wrapping(&block)
    template.content_tag(:div, 
      [template.capture(&block), error_html, hint_html].join("\n").html_safe, 
      wrapper_html_options
    )
  end

  def label_html_options
    opts = {}
    opts[:for] ||= input_html_options[:id]
    opts[:class] = [opts[:class]]

    opts
  end

  def wrapper_html_options
    opts = (options[:wrapper_html] || {}).dup
    opts[:class] =
      case opts[:class]
      when Array
        opts[:class].dup
      when nil
        []
      else
        [opts[:class].to_s]
      end
    opts[:class] << "input"
    opts[:class] << "error" if errors?
    opts[:class] << "optional" if optional?
    opts[:class] << "required" if required?
    opts[:class] << "autofocus" if autofocus?
    opts[:class] = opts[:class].join(' ')

    opts[:id] ||= wrapper_dom_id

    opts
  end
end
