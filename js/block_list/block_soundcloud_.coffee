class @block_soundcloud_

	constructor: ()->
		css = """
		#soundcloud {
				background-image: url(img/soundcloud.png);
				background-size: cover;
		}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="soundcloud" class="drag-wrap draggable source" name="soundcloud">
		</div>
		""").appendTo ".drag-zone"

	run: (element)=>
		console.log "SOUNDCLOUD RUN; no run function yet"
