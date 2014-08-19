class HomePresenter
  attr_reader :recent, :popular, :featured, :collaborators

  def initialize
    @recent = Source.limit(3).map do |c|
      SourcePresenter.new c
    end
    @popular = Source.order('popular_count DESC').limit(3).map do |s|
      SourcePresenter.new s
    end
    @featured = Source.featured.map do |c|
      SourcePresenter.new c
    end
    @collaborators = Collaborator.all
  end
end
