class AlertFilter

  attr_accessor :dmin, :dmax, :dfrom, :dto, :idesc, :ihost, :edesc, :ehost, :limit
  attr_accessor :check_status, :byday

  def initialize
    @limit = 100
  end

  def setFromParams(params)
    @dmin = params[:dmin] unless params[:dmin].blank? and @dmin.blank?
    @dmax = params[:dmax] unless params[:dmax].blank? and @dmax.blank?
    @dfrom = params[:dfrom] unless params[:dfrom].blank? and @dfrom.blank?
    @dto = params[:dto] unless params[:dto].blank? and @dto.blank?
    @idesc = params[:idesc] unless params[:idesc].blank? and @idesc.blank?
    @ihost = params[:ihost] unless params[:ihost].blank? and @ihost.blank?
    #@edesc = params[:edesc] if !params[:edesc].blank? and @edesc.blank?
    @edesc = params[:edesc] unless params[:edesc].blank? and @edesc.blank?
    #@ehost = params[:ehost] if !params[:ehost].blank? and @ehost.blank?
    @ehost = params[:ehost] unless params[:ehost].blank? and @ehost.blank?
    @limit = params[:limit].to_i unless params[:limit].blank?
    @byday = params[:byday] unless params[:byday].blank? and @byday.blank?
    @check_status = params[:check_status] unless params[:check_status].blank? and @check_status.blank?
  end

end
