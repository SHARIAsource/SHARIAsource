class HomePresenter
  attr_reader :recent, :popular, :featured, :collaborators

  def initialize
    @recent = Document.published.limit(3).map {|d| DocumentPresenter.new d }
    @popular = Document.published.order('popular_count DESC').limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.published.featured.map {|d| DocumentPresenter.new d }
    @collaborators = Collaborator.all
  end
end
