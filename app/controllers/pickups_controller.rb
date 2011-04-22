class PickupsController < ApplicationController
  # GET /pickups
  # GET /pickups.xml
  def index
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickups = @delivery.pickups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pickups }
    end
  end

  # GET /pickups/1
  # GET /pickups/1.xml
  def show
    @courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickup = @delivery.pickups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pickup }
    end
  end

  # GET /pickups/new
  # GET /pickups/new.xml
  def new
    @courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickup = @delivery.pickups.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pickup }
    end
  end

  # GET /pickups/1/edit
  def edit
    @courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickup = @delivery.pickups.find(params[:id])
  end

  # POST /pickups
  # POST /pickups.xml
  def create
    @courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickup = @delivery.pickups.new(params[:pickup])

    respond_to do |format|
      if @pickup.save
        format.html { redirect_to(courier_delivery_dropoffs_path(@courier, @delivery), :notice => 'Pickup was successfully created.') }
        format.xml  { render :xml => @pickup, :status => :created, :location => @pickup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pickup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pickups/1
  # PUT /pickups/1.xml
  def update
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickup = @delivery.pickups.find(params[:id])

    respond_to do |format|
      if @pickup.update_attributes(params[:pickup])
        format.html { redirect_to(@pickup, :notice => 'Pickup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pickup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pickups/1
  # DELETE /pickups/1.xml
  def destroy
    @courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:delivery_id])
    @pickup = @delivery.pickups.find(params[:id])
    @pickup.destroy

    respond_to do |format|
      format.html { redirect_to(pickups_url) }
      format.xml  { head :ok }
    end
  end
end
