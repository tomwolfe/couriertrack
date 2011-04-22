class DropoffsController < ApplicationController
  # GET /dropoffs
  # GET /dropoffs.xml
  def index
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoffs = @delivery.dropoffs.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dropoffs }
    end
  end

  # GET /dropoffs/1
  # GET /dropoffs/1.xml
  def show
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoff = @delivery.dropoffs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dropoff }
    end
  end

  # GET /dropoffs/new
  # GET /dropoffs/new.xml
  def new
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoff = @delivery.dropoffs.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dropoff }
    end
  end

  # GET /dropoffs/1/edit
  def edit
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoff = @delivery.dropoffs.find(params[:id])
  end

  # POST /dropoffs
  # POST /dropoffs.xml
  def create
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoff = @delivery.dropoffs.new(params[:dropoff])

    respond_to do |format|
      if @dropoff.save
        format.html { redirect_to(@dropoff, :notice => 'Dropoff was successfully created.') }
        format.xml  { render :xml => @dropoff, :status => :created, :location => @dropoff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dropoff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dropoffs/1
  # PUT /dropoffs/1.xml
  def update
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoff = @delivery.dropoffs.find(params[:id])

    respond_to do |format|
      if @dropoff.update_attributes(params[:dropoff])
        format.html { redirect_to(@dropoff, :notice => 'Dropoff was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dropoff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dropoffs/1
  # DELETE /dropoffs/1.xml
  def destroy
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @dropoff = @delivery.dropoffs.find(params[:id])
    @dropoff.destroy

    respond_to do |format|
      format.html { redirect_to(dropoffs_url) }
      format.xml  { head :ok }
    end
  end
end
