class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def user_events
    @upcoming_events = upcoming_events(current_user)
    @previous_events = previous_events(current_user)
    # @invitations = invitations(current_user)
  end

  # GET /events
  # GET /events.json
  def index
    @upcoming_events = Event.where("date > ?", Time.now).order(:date)
    @previous_events = Event.where("date < ?", Time.now).first(10)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @users = User.all
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        params[:event][:attendee_ids].each do |attendee_id|
          EventAttendee.new(event_id: @event.id, attendee_id: attendee_id).save
        end

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        # Update attendees???
      #   params[:event][:attendee_ids].each do |attendee_id|
      #     EventAttendee.new(event_id: @event.id, attendee_id: attendee_id).save
      #   end

        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name_event, :promotion, :description, :time, :date, :localtion)
    end

    def upcoming_events(user)
      user.events.where("date > ?", Time.now).order(:date)
    end

    def previous_events(user)
      user.events.where("date < ?", Time.now)
    end

    # def invitations(user)
    #   user.event_attendees
    # end
end
