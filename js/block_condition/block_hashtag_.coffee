class @block_hashtag_

	constructor: ()->
		css = """
			.hashtags {
				position: relative;
			}

			input[name='hashtaginput'] {
				position: absolute;
				left: 40px;
				top: 50px;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable filter hashtags" name="hashtag">
			<!--<form>
				#<input type="text" name="hashtaginput">
			</form>-->
			<form action="demo_form.asp" style="z-index:'1000000000'">
				First name: <input type="text" name="hashtaginput" value="Mickey"><br>
				Last name: <input type="text" name="LastName" value="Mouse"><br>
				<input type="submit" value="Submit">
			</form>
		</div>
		""").appendTo ".drag-zone"

	run: (element)=>
		console.log element
		likes = element.likes.count
		#tags is an array of strings
		tags = element.tags
		