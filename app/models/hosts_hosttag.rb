class HostsHosttag < ActiveRecord::Base
  validates_presence_of :host_id,:hosttag_id
end
