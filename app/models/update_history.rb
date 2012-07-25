class UpdateHistory < ActiveRecord::Base
  attr_accessible :inactive, :keyword, :link_id, :name, :our_site_id, :page_rank, :placement_id, :status_id, :url

  belongs_to :link
  belongs_to :placement
  belongs_to :status
  belongs_to :our_site

  validates :link_id, presence: true

  delegate :name, to: :status, prefix: true, allow_nil: true
  delegate :name, to: :placement, prefix: true, allow_nil: true
  delegate :name, to: :our_site, prefix: true, allow_nil: true
end
