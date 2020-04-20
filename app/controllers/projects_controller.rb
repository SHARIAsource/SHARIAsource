require 'will_paginate/array'

class ProjectsController < ApplicationController
  before_action :fetch_data, :fetch_filters

  def show
    if !allowed_to_view
      redirect_to root_path

      return
    end
  end

  def search
    render :show
  end

  private
  def fetch_filters
    filter_ids = params[:named_filter_id]
    # clicking a filter updates the URL, see if anything has been selected
    if filter_ids.present?
      @filters = NamedFilter.find(filter_ids)
      @check_filters = true
    else
      @filters = @project.named_filters.to_ary
      @check_filters = false
    end
    if @filters.present?
      # we build an array of searches to handle multiple named filters
      @search = []
      @filters.sort_by(&:priority).each do |filters|
        if filters.named_filter_documents.any?
          selected_documents = filters.named_filter_documents
          ref_docs = selected_documents.map(&:referenced_documents).map(&:ids).flatten
        end
        search = Document.search do |query|
          query.fulltext filters.q
          query.with(:published, true)
          query.with(:id, ref_docs) if ref_docs
          query.with(:contributor_ids, filters.contributor.id) if filters.contributor

          query.with(:region_ids, filters.region.id) if filters.region && !filters.invert_region_id
          query.without(:region_ids, filters.region.id) if filters.region && filters.invert_region_id

          query.with(:language_id, filters.language.id) if filters.language
          query.with(:document_type_id, filters.document_type.id) if filters.document_type
          query.with(:theme_ids, filters.theme.id) if filters.theme
          query.with(:topic_ids, filters.topic.id) if filters.topic
          query.with(:id, filters.named_filter_additional_documents.map(&:id).flatten) if filters.named_filter_additional_documents.any?
          query.without(:id, filters.named_filter_excluded_documents.map(&:id).flatten) if filters.named_filter_excluded_documents.any?
          query.order_by(:name)
        end
        @search.push(search)
      end
      # this was a little unusual as we were not just creating unions of different search terms, but unions of different searches. So, the following line is
      # unfortunately more complicated than would be desired
      named_results = @search.map(&:results).flatten.uniq
      @named_results = named_results.paginate :page => params[:page] || 1, :per_page => 5
    end
  end

  def fetch_data
    @project = Project.friendly.find params[:id]
    @languages = Language.rank(:sort_order)
    @languages = Language.rank(:sort_order)
    @contributors = User.joins(:documents).distinct
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
  end

  def permitted_params
    params.permit(:utf8, :q, :date_from, :date_to, :date_format, :sort, :page,
                  document_type: [], language: [], contributor: [], topic: [],
                  theme: [], region: [], era: [])
  end

  def order_field(order)
    case order
    when 'recent' then :gregorian_date
    when 'oldest' then :gregorian_date
    when 'author' then :sort_author
    end
  end

  def order_direction(order)
    order == 'recent' ? :desc : :asc
  end

  def parse_dates
    dates = [@filters.date_from, @filters.date_to].map do |date|
      if date.present?
        parts = date.split '/'
        if parts.length < 4
          parts.reverse!.map!(&:to_i)
          (3 - parts.length).times { parts.push(1) }
          DateTime.new(*parts)
        end
      end
    end
    dates[1] = dates[1] + 1.day if dates[1]
    dates
  end

  def allowed_to_view
    if current_user.nil?
      @project.published
    else
      @project.published || current_user.can_edit?(@project)
    end
  end
end
