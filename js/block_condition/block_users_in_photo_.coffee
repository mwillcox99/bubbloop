class @block_users_in_photo_

	constructor: ()->
		# if window.users_counter?
		# 	window.users_counter++
		# else
		# 	window.users_counter = 0

		# @counter = window.users_counter
		css = """
		#username_input#{window.users_counter} {
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
		<div class="drag-wrap draggable filter" name="users_in_photo">
			WITH USER @
			<input id="username_input#{window.users_counter}" type="" value="">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=users_in_photo]")
		.on 'tap click', (event) =>
			event.preventDefault()
			# $("#username_input#{window.users_counter}").val ""
			$("#username_input#{window.users_counter}").focus()


	run: (element)=>
		input = $("#username_input#{window.users_counter}").val()

		# friend is a user tagged in the photo
		for friend in element.users_in_photo
			username = friend.user.username
			full_name = friend.user.full_name.toLowerCase()
			if input is username or input.toLowerCase() is full_name
				return true
		return false
