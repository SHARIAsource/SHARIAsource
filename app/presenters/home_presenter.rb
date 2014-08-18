class HomePresenter
  attr_reader :recent_commentaries, :popular_sources

  def initialize
    @recent_commentaries = Commentary.limit(3).map do |c|
      CommentaryPresenter.new c
    end
    @popular_sources = Source.order('popular_count DESC').limit(3).map do |s|
      SourcePresenter.new s
    end
  end
end
