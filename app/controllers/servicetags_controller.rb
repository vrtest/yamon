class ServicetagsController < ApplicationController

  before_filter :authorize, :only => [:new, :edit, :delete, :create, :update, :destroy]

  # GET /servicetags
  # GET /servicetags.xml
  def index
    @servicetags = Servicetag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @servicetags }
    end
  end

  # GET /servicetags/1
  # GET /servicetags/1.xml
  def show
    @servicetag = Servicetag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @servicetag }
    end
  end

  # GET /servicetags/new
  # GET /servicetags/new.xml
  def new
    @servicetag = Servicetag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @servicetag }
    end
  end

  # GET /servicetags/1/edit
  def edit
    @servicetag = Servicetag.find(params[:id])
  end

  # POST /servicetags
  # POST /servicetags.xml
  def create
    @servicetag = Servicetag.new(params[:servicetag])

    respond_to do |format|
      if @servicetag.save
        flash[:notice] = 'servicetag was successfully created.'
        format.html { redirect_to(@servicetag) }
        format.xml  { render :xml => @servicetag, :status => :created, :location => @servicetag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @servicetag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servicetags/1
  # PUT /servicetags/1.xml
  def update
    @servicetag = Servicetag.find(params[:id])

    respond_to do |format|
      if @servicetag.update_attributes(params[:servicetag])
        flash[:notice] = 'servicetag was successfully updated.'
        format.html { redirect_to(@servicetag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @servicetag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servicetags/1
  # DELETE /servicetags/1.xml
  def destroy
    @servicetag = Servicetag.find(params[:id])
    @servicetag.destroy

    respond_to do |format|
      format.html { redirect_to(servicetags_url) }
      format.xml  { head :ok }
    end
  end
end
