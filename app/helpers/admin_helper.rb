module AdminHelper
  def hierarchy_list(hash)
    hash.map do |item, children|
      name = content_tag(:div, content_tag(:div, item[:name], class: 'name'), class: 'small-8 columns')
      actions = content_tag :div, class: 'small-4 columns actions' do
        concat link_to('Edit', url_for([:admin, item, action: :edit]), class:'tiny radius pill button')
        concat link_to('Delete', url_for([:admin, item]), class:'tiny radius alert pill button', method: :delete,
                      data: { confirm: 'Are you sure you want to delete this?'})
      end
      content_tag(:div, class: 'row') do
        concat name + actions
        if children.size > 0
          concat content_tag(:div, hierarchy_list(children), class:'small-12 columns')
        end
      end
    end.join.html_safe
  end
end
