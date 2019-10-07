module ApplicationHelper
  def admin_signed_in?
    user_signed_in? && current_user.is_admin?
  end

  def editor_signed_in?
    user_signed_in? && current_user.is_editor?
  end

  def contributor_signed_in?
    user_signed_in? && current_user.is_contributor?
  end

  def head_title(page_title)
    [page_title, 'OpenITI'].flatten.reject(&:empty?).join ' | '
  end

  def sanitize_html_fragment(html)
    Sanitize.fragment(html, Sanitize::Config::RELAXED).html_safe
  end
end
