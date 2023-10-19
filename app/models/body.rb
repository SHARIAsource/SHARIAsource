class Body < ActiveRecord::Base
  # page has a body_id and document_id, but it seems like these are mutually exclusive?
  # e.g. document 425 has 197 pages (all of which have bodies), but only 1 body with a document_id

  # Make the associations optional; worked before but after Rails 6 upgrade(?) started failing
  belongs_to :page, optional: true 
  belongs_to :document, optional: true
end
