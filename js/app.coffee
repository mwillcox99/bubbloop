
$ ->
	window.counter = 0 # this is to separate logic between conditions

	# -----------------------------
	# BLOCKS (bank layout 9-8-9)
	# -----------------------------
	# Step 1 - Celeb
	window.block_beyonce = new block_beyonce_()
	window.block_drake = new block_drake_()
	window.block_taylorswift = new block_taylorswift_()

	# Step 2 - Source
	window.block_instagram = new block_instagram_()
	window.block_spotify = new block_spotify_()
	window.block_soundcloud = new block_soundcloud_()

	# Step 3 - Filters
	window.block_filter = new block_filter_()
	window.block_hashtag = new block_hashtag_()
	window.block_temp3 = new block_filter_()

	# Step 4 - Action
	window.block_display_image = new block_display_image_()
	window.block_play_audio = new block_play_audio_()
	window.block_temp4 = new block_action_()
	# window.block_tinder = new block_tinder_()
	# window.block_display_image_fade = new block_display_image_fade_()

	# Control statements
	window.control = new control_drop_area_ ()->
		console.log "DONE"
	# new control_source_()
	# control = new control_drag_zone_(140, 0, 200)
	# new control_drag_zone_(40, 0, 200)
	# new control_drag_zone_(90, 100, 200)


	# ---------------------------
	# APPLE WATCH UI BLOCK BANK
	# ---------------------------
	items = document.querySelectorAll(".drag-wrap")

	h = window.innerHeight
	w = window.innerWidth

	# center
	c = items[Math.round(items.length / 2)]
	cr = c.getBoundingClientRect()

	onScroll = ()=>
		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (w / 2)) / (w/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css
				'-webkit-transform': "scale(#{s2})"
			++i
		return

	# set up ui on load
	onScroll cr.left - (w / 2) + cr.width / 2, cr.top - (h / 2) + cr.height / 2


	# ---------------------------------
	# DRAGGABLE GRID (BUBBLE SCROLLING)
	# ---------------------------------
	interact('.drag-zone').draggable
		inertia: true
		restrict:
				restriction: 'body'
				endOnly: true
				elementRect:
					left: 0.80
					right: 0.20
		onstart: (event) ->
		onmove: (event) =>
			$target = $ event.target
			x = (parseFloat($target.attr 'data-x') or 0) + event.dx
			# y = (parseFloat($target.attr 'data-y') or 0) + event.dy

			$target.css
				'-webkit-transform': "translate(#{x}px)"
				# '-webkit-transform': "translate(#{x}px, #{y}px)"

			$target.attr 'data-x', x
			# $target.attr 'data-y', y

			items = document.querySelectorAll(".drag-wrap")
			onScroll()


	# ---------------------------
	# DRAGGABLE BLOCKS
	# ---------------------------
	startPos = null
	interact('.draggable').draggable
		inertia: true
		restrict:
				restriction: 'body'
				endOnly: true
				elementRect:
					top: 0
					left: 0
					bottom: 1
					right: 1
			axis: 'xy'
		snap:
			targets: [ startPos ]
			relativePoints: [ {
				x: 0.5
				y: 0.5
			} ]
			range: 100
			endOnly: true

		onstart: (event) ->
			rect = interact.getElementRect event.target
			# record center point when starting the very first a drag
			startPos =
				x: rect.left + rect.width / 2
				y: rect.top + rect.height / 2
			event.interactable.draggable
				snap:
					targets: [ startPos ]
					range: 200

		onmove: (event) ->
			$target = $ event.target
			x = (parseFloat($target.attr 'data-x') or 0) + event.dx
			y = (parseFloat($target.attr 'data-y') or 0) + event.dy

			$target.css
				'-webkit-transform': "translate(#{x}px, #{y}px)"

			# update the posiion attributes
			$target.attr 'data-x', x
			$target.attr 'data-y', y
			$target.addClass 'getting--dragged'

		onend: (event) ->
			$target = $ event.target
			$target.removeClass 'getting--dragged'


	# ---------------------------
	# BUTTONS
	# ---------------------------
	cb = () =>
		console.log "RUN"
	$("#button_run").click =>
		control.run(cb)

	$("#button_reset").click =>
		location.reload()


	# ---------------------------
	# SPEECH RECOGNITION LOGIC
	# ---------------------------
	put_text_in_block = (text, block_name) ->
		$("##{block_name}").val(text)

	commands =
		'put *text in :block_name block': put_text_in_block
		'run': control.run
	annyang.addCommands commands
	annyang.start
		continuous: true