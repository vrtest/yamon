class ReporttagsController < ApplicationController

  before_filter :authorize, :only => [:new, :edit, :delete, :create, :update, :destroy]

  # GET /reporttags
  # GET /reporttags.xml
  def index
    @reporttags = Reporttag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reporttags }
    end
  end

  # GET /reporttags/1
  # GET /reporttags/1.xml
  def show
    @reporttag = Reporttag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reporttag }
    end
  end

  # GET /reporttags/new
  # GET /reporttags/new.xml
  def new
    @reporttag = Reporttag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reporttag }
    end
  end

  # GET /reporttags/1/edit
  def edit
    @reporttag = Reporttag.find(params[:id])
  end

  # POST /reporttags
  # POST /reporttags.xml
  def create
    @reporttag = Reporttag.new(params[:reporttag])

    respond_to do |format|
      if @reporttag.save
        flash[:notice] = 'Reporttag was successfully created.'
        format.html { redirect_to(@reporttag) }
        format.xml  { render :xml => @reporttag, :status => :created, :location => @reporttag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reporttag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reporttags/1
  # PUT /reporttags/1.xml
  def update
    @reporttag = Reporttag.find(params[:id])

    respond_to do |format|
      if @reporttag.update_attributes(params[:reporttag])
        flash[:notice] = 'Reporttag was successfully updated.'
        format.html { redirect_to(@reporttag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reporttag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reporttags/1
  # DELETE /reporttags/1.xml
  def destroy
    @reporttag = Reporttag.find(params[:id])
    @reporttag.destroy

    respond_to do |format|
      format.html { redirect_to(reporttags_url) }
      format.xml  { head :ok }
    end
  end
end
