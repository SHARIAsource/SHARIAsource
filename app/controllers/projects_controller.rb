require 'will_paginate/array'

class ProjectsController < ApplicationController
  before_filter :fetch_data, :fetch_filters

  def show
  end

  def paramterized_search
    @filters = SearchFilters.new permitted_params
    date_from, date_to = parse_dates
    @languages = Language.rank(:sort_order)
    @contributors = User.joins(:documents).distinct
    @topics = Topic.all
    @themes = Theme.all
    @regions = Region.hash_tree
    @eras = Era.hash_tree
    @document_types = DocumentType.hash_tree
    @search = Document.search do |query|
      query.fulltext @filters.q
      query.with(:published, true)
      query.with(:topic_ids, @filters.topic) if @filters.topic
      query.with(:theme_ids, @filters.theme) if @filters.theme
      query.with(:language_id, @filters.language) if @filters.language
      query.with(:contributor_id, @filters.contributor) if @filters.contributor
      query.with(:region_ids, @filters.region) if @filters.region
      query.with(:era_ids, @filters.era) if @filters.era
      if @filters.document_type
        query.with(:document_type_id, @filters.document_type)
      end
      if @filters.sort.present?
        query.order_by(order_field(@filters.sort),
                       order_direction(@filters.sort))
      end
      if @filters.date_format == 'ce'
        query.with(:gregorian_date).greater_than(date_from) if date_from
        query.with(:gregorian_date).less_than(date_to) if date_to
      elsif @filters.date_format == 'ah'
        query.with(:lunar_hijri_date).greater_than(date_from) if date_from
        query.with(:lunar_hijri_date).less_than(date_to) if date_to
      end
      query.paginate page: @filters.page, per_page: 20
    end
  end

  def search
    render :show
  end

  private
  def fetch_filters
    filter_ids = params[:named_filter_id]
    @filters = NamedFilter.find(filter_ids) if filter_ids.present?
    if @filters.nil?
      if permitted_params.present?
        paramterized_search
      else 
        @filters = NamedFilter.new
        @search = Document.search do |query|
          query.fulltext @filters.q
          query.with(:published, true)
          query.paginate :page => params[:page] || 1, :per_page => 5
        end
      end
    else
      #if this method  is being hit by clicking checkboxes on projects show page it will be an array
      #if not it will just be an instance of the NamedFilter class
      @search = []
    
      @filters.each do |filters|
        search = Document.search do |query|
          query.fulltext filters.q
          query.with(:published, true)
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
