class ServicesServicetag < ActiveRecord::Base
  validates_presence_of :service_id,:servicetag_id
end
