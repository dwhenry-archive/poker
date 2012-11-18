module ApplicationHelper
  def error_for(f, field, name=field)
    fieldname, error = f.object.errors.detect{|e| e[0] == field }
    if fieldname
      content_tag(:div, class: 'errors') do
        [name, error].join(' ')
      end
    end
  end
end
