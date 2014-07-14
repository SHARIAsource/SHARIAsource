module AdminHelper
  def hierarchy_list(hash)
    hash.map do |item, children|
      name = content_tag(:span, item[:name], class: 'column')
      actions = content_tag :span, class: 'column' do
        concat link_to('Edit', url_for([:admin, item, action: :edit]))
        concat link_to('Delete', url_for([:admin, item]), method: :delete,
                      data: { confirm: 'Are you sure you want to delete this?'})
      end
      content_tag(:li) do
        concat name + actions
        if children.size > 0
          concat content_tag(:ul, hierarchy_list(children))
        end
      end
    end.join.html_safe
  end
end
