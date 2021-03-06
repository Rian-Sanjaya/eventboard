class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authorize_owner!, only: [:edit, :update, :destroy]
	
	def index
		@events = Event.order(created_at: :desc)
	end

	def show
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.organizer = current_user
		if @event.save
			flash[:notice] = "Event created!"
			redirect_to @event
		else
			flash.now[:alert] = "Event not created."
			render "new"
		end
	end

	def edit
	end

	def update
		if @event.update(event_params)
			flash[:notice] = "Event updated!"
			redirect_to @event
		else
			flash[:alert] = "Event not updated"
			render "edit"
		end
	end

	def destroy
		@event.destroy
		flash[:alert] = "Event delete successfully."
		redirect_to events_url
	end

	private

		def set_event
			@event = Event.find(params[:id])

		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The page you just requested is not exist."
			redirect_to events_path
		end

		def event_params
			params.require(:event).permit(:title, :description, :start_date, :end_date, :venue, :location)
		end
		
		def authorize_owner!
			authenticate_user!
			
			unless @event.organizer == current_user
				flash[:alert] = "You do not have permission to '#{action_name}' the '#{@event.title.upcase}' event"
				redirect_to events_path
			end
		end
end
