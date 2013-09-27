class Service < ActiveRecord::Base
  validates_presence_of :host_id, :name
  belongs_to :host
  has_many :alerts
  has_and_belongs_to_many :servicetags
end
