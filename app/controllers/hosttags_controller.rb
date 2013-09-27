class HosttagsController < ApplicationController

  before_filter :authorize, :only => [:new, :edit, :delete, :create, :update, :destroy, :tag, :untag]

  # GET /hosttags
  # GET /hosttags.xml
  def index
    @hosttags = Hosttag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosttags }
    end
  end

  # GET /hosttags/1
  # GET /hosttags/1.xml
  def show
    @hosttag = Hosttag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hosttag }
    end
  end

  # GET /hosttags/new
  # GET /hosttags/new.xml
  def new
    @hosttag = Hosttag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hosttag }
    end
  end

  # GET /hosttags/1/edit
  def edit
    @hosttag = Hosttag.find(params[:id])
  end

  # POST /hosttags
  # POST /hosttags.xml
  def create
    @hosttag = Hosttag.new(params[:hosttag])

    respond_to do |format|
      if @hosttag.save
        flash[:notice] = 'Hosttag was successfully created.'
        format.html { redirect_to(@hosttag) }
        format.xml  { render :xml => @hosttag, :status => :created, :location => @hosttag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hosttag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hosttags/1
  # PUT /hosttags/1.xml
  def update
    @hosttag = Hosttag.find(params[:id])

    respond_to do |format|
      if @hosttag.update_attributes(params[:hosttag])
        flash[:notice] = 'Hosttag was successfully updated.'
        format.html { redirect_to(@hosttag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hosttag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hosttags/1
  # DELETE /hosttags/1.xml
  def destroy
    @hosttag = Hosttag.find(params[:id])
    @hosttag.destroy

    respond_to do |format|
      format.html { redirect_to(hosttags_url) }
      format.xml  { head :ok }
    end
  end
end
