class Tag < ActiveRecord::Base
  has_and_belongs_to_many :businesses

  default_scope { order("LOWER(name)") }
end
