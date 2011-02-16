class CouriersController < ApplicationController
  # GET /couriers
  # GET /couriers.xml
  def index
    @couriers = Courier.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @couriers }
    end
  end

  # GET /couriers/1
  # GET /couriers/1.xml
  def show
    @courier = Courier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @courier }
    end
  end

  # GET /couriers/new
  # GET /couriers/new.xml
  def new
    @courier = Courier.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @courier }
    end
  end

  # GET /couriers/1/edit
  def edit
    @courier = Courier.find(params[:id])
  end

  # POST /couriers
  # POST /couriers.xml
  def create
    @courier = Courier.new(params[:courier])

    respond_to do |format|
      if @courier.save
        format.html { redirect_to(@courier, :notice => 'Registration successfull.') }
        format.xml  { render :xml => @courier, :status => :created, :location => @courier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @courier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /couriers/1
  # PUT /couriers/1.xml
  def update
    @courier = Courier.find(params[:id])

    respond_to do |format|
      if @courier.update_attributes(params[:courier])
        format.html { redirect_to(@courier, :notice => 'Courier was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @courier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /couriers/1
  # DELETE /couriers/1.xml
  def destroy
    @courier = Courier.find(params[:id])
    @courier.destroy

    respond_to do |format|
      format.html { redirect_to(couriers_url) }
      format.xml  { head :ok }
    end
  end
end
