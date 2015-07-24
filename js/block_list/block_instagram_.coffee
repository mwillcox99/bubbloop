class @block_instagram_

	constructor: ()->
		css = """
		#instagram_pic {
			position: absolute;
			left: 23px;
			top: 23px;
			width: 100px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable source" name="instagram">
			<img id="instagram_pic" src="img/instagram.png">
		</div>
		<div id="instafeed"></div>
		""").appendTo ".drag-zone"

	#constructs an array to pass back to the list
	run: (celeb, cb) =>
		@uploaded_count = 0
		$("<img src='img/load2.gif' style='position:absolute;top:10px;left:10px;width:350px;height:auto;z-index:1004;'>").appendTo $("body")
		$("<div id='compilation-animation' style='position:absolute;top:200px;left:90px;font-size:250%;color:white;z-index:1005;'>COMPILING</div>").appendTo $("body")
		$("<div id='progress-animation' style='position:absolute;top:250px;left:80px;font-size:150%;color:white;z-index:1005;'>0 PICTURES LOADED</div>").appendTo $("body")
		$("#new-button").remove()

		@current_interval = 0

		setInterval =>
			@current_interval++
			if @current_interval > 3
				@current_interval = 0
			dots = ""
			for cur in [0...@current_interval] by 1
				dots += "."

			$("#compilation-animation").text "COMPILING#{dots}"
		, 500

		#get the feed for instagram
		@all_posts = []
		@feed = new Instafeed
			get: 'user'
			userId: celeb.instagram_id
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			limit: 60
			error: ()->
				console.log "instagram error"
			success: (json)=>
				list = json.data
				# loops to concatenate
				for cur in list
					@uploaded_count++
					@all_posts.push cur
					console.log cur
				$("#progress-animation").text "#{@uploaded_count} PICTURES LOADED"
				setTimeout @loop_done, 0, cb

		@feed.run()

	loop_done: (cb) =>
		if @feed.hasNext()
			@feed.next()
		else
			console.log "NOPE WTF IS THIS SHIIIIIT FILTHY"
			cb @all_posts