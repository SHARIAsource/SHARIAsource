class HomePresenter
  attr_reader :recent, :popular, :featured, :projects, :libraries

  def initialize
    @recent = Document.published.latest.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @popular = Document.published.popular.within_last_eighteen.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.published.featured.map do |d| 
      DocumentPresenter.new d
    end
    @projects = Project.published.featured.limit(3).map do |d|
      ProjectPresenter.new d
    end
    @libraries = Collaborator.featured.limit(3).map do |d|
      LibraryPresenter.new d
    end
  end
end
