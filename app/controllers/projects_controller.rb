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
    @filters = NamedFilter.find(filter_ids) if filter_ids.present?
    if @filters.nil?
      @filters = NamedFilter.new
      @search = Document.search do |query|
        query.fulltext @filters.q
        query.with(:published, true)
        query.paginate :page => 1, :per_page => 5
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
      logger.debug "search: #{@search.length}"
      named_results = @search.map(&:results).inject(nil) {|all_results, search_results| all_results = [] if all_results.nil?; all_results + search_results}
      @named_results = named_results.paginate :page => params[:page] || 1, :per_page => 5
      logger.debug "named results: #{@named_results}"
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
end
