# Fake content for local development and the Playwright tests. Everything
# below is invented: real people and documents stay out of this file.
load Rails.root.join('db', 'seeds', 'production.rb')
return if Document.exists?

# Production renamed the root document types after the seeds were written.
{
  'Secondary Sources' => 'Sources By School',
  'Policy Papers' => 'Expert Analysis',
  'Amicus Briefs' => 'Other Legal Documents',
  'Additional Legal Documents' => 'Special Collections'
}.each { |old, new| DocumentType.find_by!(name: old).update!(name: new) }
DocumentType.find_by!(name: 'Commentary').update!(parent: DocumentType.find_by!(name: 'Expert Analysis'))

Region.find_by!(name: 'Afghanistan').update!(latitude: 33, longitude: 66)

libraries = (1..3).map do |position|
  Collaborator.create!(name: "Example Library #{position}", url: 'https://example.org', featured_library_position: position)
end

users = %w[Editor Contributor].map do |title|
  User.create!(
    email: "#{title.downcase}@example.org",
    password: 'testpassword',
    first_name: 'Example',
    last_name: title,
    role: Role.create!(title: title),
    collaborator: libraries.first,
    term_start_year: 2020,
    term_end_year: 2024
  )
end

author = Author.create!(name: 'Example Author')

[
  ['Historical Primary Sources', 'Afghanistan', 1],
  ['Contemporary Primary Sources', 'Nigeria', 2],
  ['Sources By School', 'Afghanistan', 3],
  ['Expert Analysis', 'Nigeria', nil],
  ['Other Legal Documents', 'Afghanistan', nil],
  ['Special Collections', 'Nigeria', nil]
].each_with_index do |(document_type, region, featured_position), index|
  Document.create!(
    title: "Example #{document_type}",
    summary: 'An invented document for testing.',
    published: true,
    popular_count: index + 1,
    featured_position: featured_position,
    document_style: 'noscan',
    document_type: DocumentType.find_by!(name: document_type),
    language: Language.first,
    reference_type: ReferenceType.first,
    user: users.first,
    authors: [author],
    contributors: [users[index % users.length]],
    topics: [Topic.first],
    themes: [Theme.first],
    regions: [Region.find_by!(name: region)],
    eras: [Era.find_by!(name: 'ʿAbbāsids')]
  )
end
Sunspot.commit

(1..3).each do |position|
  project = Project.create!(name: "Example Project #{position}", published: true, featured_position: position)
  ProjectsUser.create!(project: project, user: users.first, project_role: 'Editor', sort_order: 1)
end

Misc.create!(slug: 'about', title: 'About SHARIAsource', body: <<~HTML)
  <h4>Who We Are</h4><p>Example text.</p>
  <h4>What We Do</h4><p>Example text.</p>
  <h4>What We Cover</h4><p>Example text.</p>
  <h4>How You Can Contribute</h4><p>Example text.</p>
HTML
Misc.create!(slug: 'credits', title: 'Credits', body: <<~HTML)
  <p>Dates are from <a href="http://www.muslimphilosophy.com/ip/hijri.htm" target="_blank" rel="noopener">Islamic Philosophy Online</a>.</p>
HTML
Misc.create!(slug: 'resources', title: 'Browse Projects & Special Collections', body: <<~HTML)
  <h3>SHARIAsource PROJECTS</h3><p>Example text.</p>
  <h3>SPECIAL COLLECTIONS</h3><p>Example text.</p>
  <h3>ADDITIONAL RESOURCES: Editors' Picks</h3><p>Example text.</p>
HTML
