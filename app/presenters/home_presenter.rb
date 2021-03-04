class HomePresenter
  attr_reader :recent, :popular, :featured, :projects

  def initialize
    @recent = Document.published.latest.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @popular = Document.published.popular.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.published.featured.map do |d| 
      DocumentPresenter.new d
    end
    @projects = Project.published.featured.limit(3).map do |d|
      ProjectPresenter.new d
    end
  end
end
