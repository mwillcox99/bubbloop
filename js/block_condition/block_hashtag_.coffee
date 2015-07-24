class @block_hashtag_

	constructor: ()->
		if window.hashtag_counter?
			window.hashtag_counter++
		else
			window.hashtag_counter = 0

		@counter = window.hashtag_counter
		css = """
		#hashtag_input#{window.hashtag_counter} {
			position: absolute;
			top: 55%;
			width: 80%;
			left: 6%;
			text-align: center;
			/*font-size: 11px;*/
		}

		input[type='text'],
		input[type='number'],
		textarea {
			font-size: 16px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable filter" name="hashtag">
			HASHTAG #
			<input id="hashtag_input#{window.hashtag_counter}" type="text" value="">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=hashtag]")
		.on 'tap click', (event) =>
			event.preventDefault()
			$("#hashtag_input#{window.hashtag_counter}").focus()



	run: (element)=>
		# tags is an array of strings
		tags = element.tags
		tag = $("#hashtag_input#{@counter}").val().toLowerCase()

		lower_tags = tags.map (string)->
			return string.toLowerCase()

		for cur_tag in lower_tags
			if cur_tag.indexOf(tag) isnt -1
				return true
		return false
		# if $.inArray(tag, lower_tags) is -1
		# 	return false
		# return true