class Category < ActiveRecord::Base
  has_many :our_sites

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  def our_sites_for(user)
    if user.admin?
      our_sites
    else
      our_sites.visible_for(user.id)
    end
  end

  class << self
    def visible_for(user)
      if user.admin?
        Categoy.all
      else
        OurSite.visible_for(user.id).map(&:category)
      end
    end
  end
end
