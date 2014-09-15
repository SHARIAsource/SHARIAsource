class EraPresenter < BasePresenter
  def name_with_dates
    if @object.depth > 0
      "#{@object.name}, #{dates}"
    else
      @object.name
    end
  end

  def dates
    if @object.hijri_display.present?
      "#{@object.hijri_display} / #{@object.gregorian_display}"
    else
      "#{hijri_range} / #{gregorian_range}"
    end
  end

  def hijri_range
    "#{@object.start_year_hijri}-#{@object.end_year_hijri}"
  end

  def gregorian_range
    "#{@object.start_year_gregorian}-#{@object.end_year_gregorian}"
  end
end
