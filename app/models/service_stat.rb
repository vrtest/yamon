class ServiceStat < Service
  attr_accessor :sum_status, :sum_status_excluded
  attr_accessor :percent_status, :percent_status_excluded
  attr_accessor :disponibility

  after_initialize :set_arrays

  def set_arrays
    @sum_status = []
    @sum_status_excluded = []
    @percent_status = []
    @percent_status_excluded = []
  end

end
