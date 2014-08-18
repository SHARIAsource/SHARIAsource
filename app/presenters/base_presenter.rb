class BasePresenter
  NUM_REFERENCES_DISPLAYED = 3

  attr_reader :object

  def initialize(object)
    @object = object
  end

  def created_at
    @object.created_at.to_s :dd_month_yyyy
  end

  def method_missing(method)
    @object.send(method) rescue nil
  end
end
