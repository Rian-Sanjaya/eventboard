module ApplicationHelper
	def full_title(page_title = '')
		base_title = 'Eventsboard'
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
	
	def time_format(event_date)
		event_date.strftime('%A, %d %b %Y %l:%M %p')
	end
end
