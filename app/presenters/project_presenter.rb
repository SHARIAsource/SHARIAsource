# -*- coding: utf-8 -*-
class ProjectPresenter < BasePresenter
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers

  REFERENCE_LIMIT = 3

  def lunar_hijri_date
    created_at.to_time.to_hijri
  end

  def lunar_hijri_day
    lunar_hijri_date.day
  end

  def lunar_hijri_month
    lunar_hijri_date.month
  end

  def lunar_hijri_year
    lunar_hijri_date.year
  end

  def dates
    # Need to extract gregorian_year, month, day from created_at
    gregorian_year = created_at.to_date.year
    gregorian_month = created_at.to_date.month
    gregorian_day = created_at.to_date.day

    gregorian = []
    lunar_hijri = []
    if gregorian_year.present?
      gregorian << gregorian_year
      lunar_hijri << lunar_hijri_year
      if gregorian_month.present?
        gregorian.unshift(I18n.translate('date.month_names', locale: :en)[gregorian_month])
        lunar_hijri.unshift(I18n.translate('date.month_names', locale: :en_ar)[lunar_hijri_month])
        if gregorian_day.present?
          gregorian.unshift(gregorian_day)
          lunar_hijri.unshift(lunar_hijri_day)
        end
      end
      "#{lunar_hijri.join(' ')} / #{gregorian.join(' ')}"
    else
      month = I18n.translate('date.month_names',
                             locale: :en_ar)[lunar_hijri_month]
      [
        "#{lunar_hijri_year} #{month} #{lunar_hijri_year}",
        gregorian_date.to_s(:dd_month_yyyy)
      ].join(' / ')
    end
  end

  def ordered_contributors
    # would like a single query using the association, but can't figure that out
    # eg editors = users.includes(:projects_users).where.not(projects_users.project_role="Research Assistant").order('projects_users.sort_order ASC')
    # https://stackoverflow.com/questions/32956400/rails-order-by-a-field-in-parent-belongs-to-association/32956573
    filtered = projects_users.where(project_role: "Research Assistant").or(projects_users.where(project_role: "Student Editor")).order('sort_order')
    filtered_users = Array.new
    filtered.each do |j|
      filtered_users.push(User.find(j.user_id))
    end
    filtered_users
  end

  def ordered_editors 
    filtered = projects_users.where.not(project_role: ["Research Assistant", "Student Editor"]).order('sort_order')
    filtered_users = Array.new
    filtered.each do |j|
      filtered_users.push(User.find(j.user_id))
    end
    filtered_users
  end
end
