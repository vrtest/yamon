class HostsController < ApplicationController

  before_filter :authorize, :only => [:new, :edit, :delete, :create, :update, :destroy, :tag, :untag]

  # GET /hosts
  # GET /hosts.xml
  def index
    @hosts = Host.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end

  # GET /hosts/1
  # GET /hosts/1.xml
  def show
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # GET /hosts/new
  # GET /hosts/new.xml
  def new
    @host = Host.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # GET /hosts/1/edit
  def edit
    @host = Host.find(params[:id])
  end

  # POST /hosts
  # POST /hosts.xml
  def create
    @host = Host.new(params[:host])

    respond_to do |format|
      if @host.save
        flash[:notice] = 'Host was successfully created.'
        format.html { redirect_to(@host) }
        format.xml  { render :xml => @host, :status => :created, :location => @host }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @host.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hosts/1
  # PUT /hosts/1.xml
  def update
    @host = Host.find(params[:id])

    respond_to do |format|
      if @host.update_attributes(params[:host])
        flash[:notice] = 'Host was successfully updated.'
        format.html { redirect_to(@host) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @host.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.xml
  def destroy
    @host = Host.find(params[:id])
    @host.destroy

    respond_to do |format|
      format.html { redirect_to(hosts_url) }
      format.xml  { head :ok }
    end
  end

  # tag a host  #TODO add error flash
  def tag
    HostsHosttag.create(:hosttag_id => params[:hosttag_id],
                                 :host_id => params[:host_id])
    flash[:notice] = "Tag added"
    redirect_to :action => :edit, :id => params[:host_id]
  end

  # untag a host
  #TODO add error flash
  def untag
    host=Host.find(params[:host_id])
    hosttag=Hosttag.find(params[:hosttag_id])
    host.hosttags.delete(hosttag)
#    HostsHosttag.destroy_all({:hosttag_id => params[:hosttag_id],
#                                       :host_id => params[:report_id]})
    flash[:notice] = "Tag removed"
    redirect_to :action => :edit, :id => params[:host_id]
  end

end
