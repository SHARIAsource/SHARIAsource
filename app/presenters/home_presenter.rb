class HomePresenter
  attr_reader :recent, :popular, :featured

  def initialize
    # NOTE: This content needs to be created with this slug in order to
    #   populate the "about" blurb displayed on the home page.
    @recent = Document.published.latest.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @popular = Document.published.popular.limit(3).map do |d|
      DocumentPresenter.new d
    end
    @featured = Document.published.featured.map {|d| DocumentPresenter.new d }
  end
end
