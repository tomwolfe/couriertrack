class CourierSessionsController < ApplicationController
  # GET /courier_sessions
  # GET /courier_sessions.xml
  def index
    @courier_sessions = CourierSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courier_sessions }
    end
  end

  # GET /courier_sessions/1
  # GET /courier_sessions/1.xml
  def show
    @courier_session = CourierSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @courier_session }
    end
  end

  # GET /courier_sessions/new
  # GET /courier_sessions/new.xml
  def new
    @courier_session = CourierSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @courier_session }
    end
  end

  # GET /courier_sessions/1/edit
  def edit
    @courier_session = CourierSession.find(params[:id])
  end

  # POST /courier_sessions
  # POST /courier_sessions.xml
  def create
    @courier_session = CourierSession.new(params[:courier_session])

    respond_to do |format|
      if @courier_session.save
        format.html { redirect_to(:couriers, :notice => 'Successfully logged in.') }
        format.xml  { render :xml => @courier_session, :status => :created, :location => @courier_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @courier_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courier_sessions/1
  # PUT /courier_sessions/1.xml
  def update
    @courier_session = CourierSession.find(params[:id])

    respond_to do |format|
      if @courier_session.update_attributes(params[:courier_session])
        format.html { redirect_to(@courier_session, :notice => 'Courier session was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @courier_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courier_sessions/1
  # DELETE /courier_sessions/1.xml
  def destroy
    @courier_session = CourierSession.find(params[:id])
    @courier_session.destroy

    respond_to do |format|
      format.html { redirect_to(:couriers, :notice => 'Goodbye!') }
      format.xml  { head :ok }
    end
  end
end
