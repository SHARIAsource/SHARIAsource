class UserPresenter < BasePresenter
  def name_with_collaborator
    [name, collaborator.try(:name)].compact.join(', ')
  end

  def biography_uses_tabs?
    is_senior_scholar?
  end

  def biography_sections
    # partial filename => tab text for that section
    tabs = {}
    tabs['about'] = 'Biography'
    tabs['publications'] = 'Publications'
    tabs['syllabi'] = 'Syllabi'
    tabs['other_links'] = 'Other Links'
    tabs
  end

  def get_syllabi
    doc_type = DocumentType.find_by_name "Islamic Law Teaching"
    syllabus = ReferenceType.find_by_name "Syllabus"
    Document.where(contributor_id: id,
                   reference_type_id: syllabus,
                   document_type_id: doc_type)
  end

  def sections_with_content
    # Returns a hash of section names mapped to their content, which
    # might be nil
    @sections_with_content ||= {
      'about' => about,
      'publications' => publications,
      'syllabi' =>  get_syllabi,
      'other_links' => other_links,
    }.reject { |k, v| v.blank? }
  end

end
