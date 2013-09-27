class Report < ActiveRecord::Base
  validates_presence_of :label
  has_many :alerts
  has_and_belongs_to_many :reporttags
end
