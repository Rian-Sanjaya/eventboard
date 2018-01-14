class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def index
		@events = Event.all
	end

	def show
	end

	def new
		@event = Event.new
	end

	def create
		if @event.save
			flash[:notice] = "Event created!"
			redirect_to @event
		else
			flash.now[:alert] = "Event not created."
			render "new"
		end
	end

	def edit
		@event = Event.find(params[:id])
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
end
