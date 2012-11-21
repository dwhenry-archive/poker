module ApplicationHelper
  def error_for(f, field, name=field)
    fieldname, error = f.object.errors.detect{|e| e[0] == field }
    if fieldname
      content_tag(:div, class: 'errors') do
        [name, error].join(' ')
      end
    end
  end


  def average_me(set, block)
    values = set.map(&block).select{|a| a}
    return '-' if values.empty?
    values.sum / values.count
  end

  def sum_me(set, block)
    values = set.map(&block).select{|a| a}
    return '-' if values.empty?
    values.sum
  end
end
