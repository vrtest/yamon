class Host < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name
  has_and_belongs_to_many :hosttags
  has_many :services
end
