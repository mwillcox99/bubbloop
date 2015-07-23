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

	run: (celeb, loop_func) =>
		#get the feed for instagram
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
				loop_func list, @loop_done

		@feed.run()

	loop_done: () =>
		if @feed.hasNext()
			@feed.next()
		else return