$(window).on('load', function() {
	$(".profile-followers").on('click', function() {
		$(".followers-modal").addClass("modal-active");
		$(".modal_overlay").addClass("modal_overlay_active");
	});

	$(".profile-following").on('click', function() {
		$(".following-modal").addClass("modal-active");
		$(".modal_overlay").addClass("modal_overlay_active");
	});

	$(".modal_overlay").on("click", function() {
		$(".modal_overlay").removeClass("modal_overlay_active");
		$(".followers-modal").removeClass("modal-active");
		$(".following-modal").removeClass("modal-active");
	});

	/******************************* Image Preview ***************/


	var preview = $(".upload-preview img");

	// Previews the image when user selects img file to submit
  $(".img-file").change(function(event){
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();
    reader.onload = function(e){
        image_base64 = e.target.result;
        preview.attr("src", image_base64);	
    };
    reader.readAsDataURL(file);
		$('.img-responsive100').css({"border" : "4px solid #808080" });
		  });

	/********************* Comments Form *****************/

	$('.glyphicon-comment').on('click', function() {
		$($(this).parent().parent().last()).find('textarea[name="comment[content]"]').focus();
	});

	// Need token for ajax call
	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
	
	// This mimics an ajax submission form when user presses enter button
	// inside the comment text area.
	$('.comment-text-area').keypress(function(e) {
		if (e.which == 13 && !e.shiftKey) {
			$form = $(this).closest("form")[0];
			var valuesToSubmit = $form.serialize;
			$.ajax({
				url: $form.action,  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'POST',
				data: {
					comment: {	
						content: $($form).find('textarea[name="comment[content]"]').val(), 
						profile_id: $($form).find('input[name="comment[profile_id]"]').val(), 
						post_id: $($form).find('input[name="comment[post_id]"]').val() 
					},
					authenticity_token: AUTH_TOKEN
				}
			});
		}
	});

	/******************************* get comments ************/
		var currentPage = 2;
		$('.more-comments-link').on('click', function() {
			var id = $(this).attr('id');
			var post_id = parseInt(id.charAt(id.length - 1));
			
			$.ajax({
				type: "GET",
				url: "/get_comments",
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				data: {
					post_id: post_id,
					page: currentPage
				},
				success: function(data) {
					currentPage = currentPage + 1;
				}
			});
		});
});
