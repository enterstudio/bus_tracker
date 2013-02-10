class BusRoute < ActiveRecord::Base
  attr_accessible :name, :route_outline

  validates_uniqueness_of :name

  def self.named(name)
    where(:name=>name).first
  end

end
