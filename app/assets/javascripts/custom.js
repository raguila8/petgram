$(document).on('turbolinks:load', function() {
	/*$(".profile-followers").on('click', function() {
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
	});*/

	/******************************* Image Preview ***************/

	// Need token for ajax call
	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');



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

	if ($("#profile-body").length || $('.profile-edit-page').length) {
		$('.profile-img-file').on('change', function() {
			$('.profile-img-edit').submit();
		});

		$('.card-box-posts').on('click', function() {
			$('html, body').animate({
				scrollTop: $(".profile-posts-gallery").offset().top - 67}, 'slow');
		});
	}


	/******************** Load more comments for posts#show view ************/
	var page = 2;
	$('#post-show-container').on('click', '.more-comments-link', function() {
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(14, id.length));
			
		$.ajax({
			type: "GET",
			url: "/get_comments",
			headers: {
				Accept: "text/javascript; charset=utf-8",
				"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			data: {
				post_id: post_id,
				page: page
			},
			success: function(data) {
				page = page + 1
			}
		});
	});
	
	/************************* Submit form on enter for posts#edit view *******/

	
	// This mimics an ajax submission form when user presses enter button
	// inside the comment text area.
	$('#post-edit-container').on('keypress', '.post-container textarea', function(e) {	
		if (e.which == 13 && !e.shiftKey) {
			var id = $(this).attr('id');
			var post_id = parseInt(id.substring(15, id.length));

			$form = $(this).closest('form')[0];
			//var valuesToSubmit = $form.serialize;
			$.ajax({
				url: "/posts/" + post_id,  // submits it to the given url of the form
				headers: {
					Accept: "text/html; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'PATCH',
				data: {
					post: {	
						description: $($form).find('textarea[name="post[description]"]').val()
					},
					authenticity_token: AUTH_TOKEN
				}
			});
		}
	});

	/**************************** Mark notifications as read **************/

	$('#notifications-modal').on('hidden.bs.modal', function() {
		$.ajax({
			url: "/read_notifications",  // submits it to the given url of the form
			headers: {
				Accept: "text/javascript; charset=utf-8",
				"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			type: 'GET',		
			data: {
				authenticity_token: AUTH_TOKEN
			}
		});

	});

	if ($('body').length) {
		console.log("lwkflke");
		$('.image-picker').imagepicker();
	}

});
