class HomePresenter
  attr_reader :recent, :popular, :featured

  def initialize
    @recent = Document.published.latest.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @popular = Document.published.popular.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.published.featured.map {|d| DocumentPresenter.new d }
  end
end
