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
    @delivery = @courier.deliveries.build

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

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to(courier_delivery_path(@courier, @delivery), :notice => 'Delivery was successfully created.') }
        format.xml  { render :xml => @delivery, :status => :created, :location => @delivery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @delivery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deliveries/1
  # PUT /deliveries/1.xml
  def update
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:id])

    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        format.html { redirect_to(courier_delivery_path(@courier, @delivery), :notice => 'Delivery was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @delivery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.xml
  def destroy
  	@courier = Courier.find(params[:courier_id])
    @delivery = @courier.deliveries.find(params[:id])
    @delivery.destroy

    respond_to do |format|
      format.html { redirect_to(courier_deliveries_url) }
      format.xml  { head :ok }
    end
  end
end
