class HomePresenter
  attr_reader :recent, :popular, :featured, :collaborators

  def initialize
    @recent = Document.limit(3).map {|d| DocumentPresenter.new d }
    @popular = Document.order('popular_count DESC').limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.featured.map {|d| DocumentPresenter.new d }
    @collaborators = Collaborator.all
  end
end
