class Misc < ActiveRecord::Base
  include HasManyAttachedFiles

  alias_attribute :name, :title

  validates :slug, presence: true, uniqueness: true
  # CloudFront sends /media* and /static* to the Hub's file bucket before the
  # request reaches Rails, so a page under either prefix would never load.
  validates :slug, format: { without: /\A(media|static)/,
                             message: 'cannot start with "media" or "static": the CDN reserves those paths' }
  validates :title, presence: true

end
