class HomePresenter
  attr_reader :popular, :featured, :collaborators

  def initialize
    @recent = Document.published.latest.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @popular = Document.published.popular.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.published.featured.map {|d| DocumentPresenter.new d }
    @collaborators = Collaborator.rank(:sort_order).all
  end
end
