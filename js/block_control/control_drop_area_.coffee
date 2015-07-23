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
				@source = new control_drag_zone_ 50, 70, 180, 'source'

			when 2
				#expand to overlap once
				@filter = new control_drag_zone_ 120, 70, 180, 'filter'
			when 3
				#expand to triple circles
				@action = new control_drag_zone_ 85, 162, 180, 'action'
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
				<p style='position:absolute;left: 28px;top:22px;' >RUN!</p>
			</div>
		""")
		$new_div.css
			'border-radius': '100px'
			width: '90px'
			height: '90px'
			position: 'absolute'
			top: '153px'
			left: '130px'
			'z-index': '10000'
			'background-color': 'white'
		$("body").prepend $new_div
		$new_div.addClass 'can--drop'
		$new_div.bind 'tap click',()=>
			@run()

	run: (outer_cb)->
		celeb = @celebrity.run()
		@source.run celeb, (list) =>
			async.forEachOfSeries list, (element, i, cb) =>
				if @filter.run element
					@action.run element, cb
				else
					console.log "Element does not pass filter"
					cb()
				return
			, (err) ->
				if outer_cb?
					outer_cb()

