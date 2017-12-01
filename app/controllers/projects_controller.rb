require 'will_paginate/array'

class ProjectsController < ApplicationController
  before_filter :fetch_data, :fetch_filters

  def show
  end

  def search
    render :show
  end

  private
  def fetch_filters
    filter_ids = params[:named_filter_id]
    #clicking a filter updates the URL, see if nothing has been selected
    @filters = filter_ids.present? ? @filters = NamedFilter.find(filter_ids) : nil
    if @filters.present?
      #if this method is being hit by clicking checkboxes on projects show page it will be an array
      @search = []
      @filters.each do |filters|
        if filters.named_filter_documents.any?
          selected_documents = filters.named_filter_documents
          ref_docs = selected_documents.map(&:referenced_documents).map(&:ids).flatten
        end
        search = Document.search do |query|
          query.fulltext filters.q
          query.with(:published, true)
          query.with(:id, ref_docs) if ref_docs
          query.with(:contributor_id, filters.contributor.id) if filters.contributor
          query.with(:region_ids, filters.region.id) if filters.region
          query.with(:language_id, filters.language.id) if filters.language
          query.with(:document_type_id, filters.document_type.id) if filters.document_type
          query.with(:theme_ids, filters.theme.id) if filters.theme
          query.with(:topic_ids, filters.topic.id) if filters.topic
        end
        @search.push(search)
      end
      named_results = @search.map(&:results).inject(nil) {|all_results, search_results| all_results = [] if all_results.nil?; all_results + search_results}
      @named_results = named_results.paginate :page => params[:page] || 1, :per_page => 5
    end
  end

  def fetch_data
    @project = Project.find params[:id]
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

end
