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

	run: (celeb, cb) =>
		# background music
		audio = new Audio "sound/#{celeb.name}.mp3"
		audio.play()

		# get the feed for instagram
		feed = new Instafeed
			get: 'user'
			userId: celeb.instagram_id
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)->
				cb json.data

		feed.run()