class HomePresenter
  attr_reader :recent_commentaries

  def initialize
    @recent_commentaries = Commentary.limit(3).map do |c|
      CommentaryPresenter.new c
    end
  end
end
