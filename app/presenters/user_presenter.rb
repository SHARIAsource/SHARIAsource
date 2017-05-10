class UserPresenter < BasePresenter
  def name_with_collaborator
    [name, collaborator.try(:name)].compact.join(', ')
  end

  def biography_uses_tabs?
    is_senior_scholar?
  end

  def biography_sections
    # partial filename => tab text for that section
    {
      'about' => 'Biography',
      'publications' => 'Publications',
      'syllabi' => 'Syllabi',
      'other_links' => 'Other Links',
    }
  end

  def sections_with_content
    # Returns a hash of section names mapped to their content, which
    # might be nil
    @sections_with_content ||= {
      'about' => about,
      'publications' => 'Publication content',
      'syllabi' => 'Syllabi content',
    }
  end

end
