class @control_drop_area_

	constructor: ()->
		css = """
			.drop_area {
				position: relative;
			}

			#new-button {

			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id='current-step' class='text'></div>
		<div class='drop_area' role='drop_area'></div>
		""").appendTo $("body")

		@zones = 1
		@celebrity = new control_drag_zone_ 5, 50, 365, 'celeb'


	expand: () ->
		current_counter = window.counter
		# console.log counter
		switch current_counter
			when 1 #this is after celeb has been dragged in
				#will expand to drop zone in celeb
				@source = new control_drag_zone_ 45, 75, 205, 'source'
				# @source.run(@celebrity)

			when 2
				#expand to overlap once
				@filter = new control_drag_zone_ 125, 75, 205, 'filter'

			when 3
				#expand to triple circles
				@action = new control_drag_zone_ 85, 182, 205, 'action'
			when 4
				#run button shows up!
				@create_button()

	create_button: () ->
		$blacken = $("<div></div>").css
			'z-index':'500'
			'opacity': '0.5'
			'background-color': 'black'
			width: '100%'
			height: '100%'
			position: 'absolute'
			left: '0px'
			top: '0px'

		$("body").prepend $blacken

		$new_div = $("""
			<div id="new-button">
				<p style='position:absolute;font-size: 25px;left:17px;top:5px;' >RUN!</p>
			</div>
		""")

		$new_div.css
			borderRadius: 100
			width: 90
			height: 90
			position: 'absolute'
			top: 180
			left: 140
			zIndex: 10000
			backgroundColor: 'white'
		$("body").prepend $new_div
		$new_div.addClass 'can--drop'
		$new_div.bind 'tap click',()=>
			@run()

	run: ()->
		celeb_name = @celebrity.run()

		@source.run celeb_name, (list, outer_cb) =>
			# This is the for loop that iterates through the feed
			async.forEachOfSeries list, (element, i, cb) =>
				if @filter.run element
					@action.run element, cb
				else
					cb()
				return
			, (err) ->
				if outer_cb?
					outer_cb()
				else
					console.log "LOOP ENDED W/O OUTER_CB"