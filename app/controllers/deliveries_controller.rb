class DeliveriesController < ApplicationController
  # GET /deliveries
  # GET /deliveries.xml
  def index
  	@courier = Courier.find(params[:courier_id])
    @deliveries = @courier.deliveries.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deliveries }
    end
  end

  # GET /deliveries/1
  # GET /deliveries/1.xml
  def show
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @delivery }
    end
  end

  # GET /deliveries/new
  # GET /deliveries/new.xml
  def new
  	@courier = Courier.find(params[:courier_id])
    if params[:search_id]
    	search = Search.find(params[:search_id])
    	@delivery = @courier.deliveries.build(:pickup_address => search.pickup_address, :mass => search.min_mass, :volume => search.min_volume, :delivery_due => search.delivery_due)
    else
    	@delivery = @courier.deliveries.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @delivery }
    end
  end

  # GET /deliveries/1/edit
  def edit
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:id])
  end

  # POST /deliveries
  # POST /deliveries.xml
  def create
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.build(params[:delivery])
    @courier.add_delivery_mass_and_volume(@delivery)

    respond_to do |format|
      if @delivery.valid? & @courier.valid?
      	Delivery.transaction do
      		@courier.save!
      		@delivery.save!
      		format.html { redirect_to(courier_delivery_pickups_path(@courier, @delivery), :notice => 'Delivery was successfully created.') }
        	format.xml  { render :xml => @delivery, :status => :created, :location => @delivery }
      	end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @delivery.errors + @courier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deliveries/1
  # PUT /deliveries/1.xml
  def update
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:id])
    @courier.remove_delivery_mass_and_volume(@delivery)
    @delivery.attributes = params[:delivery] # rather than update_attributes so not saved until transaction
    @courier.add_delivery_mass_and_volume(@delivery)

    respond_to do |format|
      if @delivery.valid? & @courier.valid?
      	Delivery.transaction do
      		@courier.save!
      		@delivery.save!
      		format.html { redirect_to(courier_delivery_path(@courier, @delivery), :notice => 'Delivery was successfully updated.') }
        	format.xml  { head :ok }
      	end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @delivery.errors + @courier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.xml
  def destroy
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:id])
    @courier.remove_delivery_mass_and_volume(@delivery)
    @delivery.destroy

    respond_to do |format|
      format.html { redirect_to(courier_deliveries_url) }
      format.xml  { head :ok }
    end
  end
end
