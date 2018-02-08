$(document).ready(function() {
    
	/******************* open modal **************/

	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

	$('.profile-post-container').on('click', function() {
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(15, id.length));
		var prev = $(this).closest('.col-lg-4').prev('.col-lg-4').find('.profile-post-container');
		var prev_post_id;
		if (prev.length) {
			var prev_id = prev.attr('id');
			prev_post_id = parseInt(prev_id.substring(15, id.length));
		} else {
			prev_post_id = -1;
		}

		var next = $(this).closest('.col-lg-4').next('.col-lg-4').find('.profile-post-container');

		var next_post_id;
		if (next.length) {
			var next_id = next.attr('id');
			next_post_id = parseInt(next_id.substring(15, id.length));
		} else {
			next_post_id = -1;
		}

		$.ajax({
				url: '/post_modal',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'GET',
				data: {	
					authenticity_token: AUTH_TOKEN,
					post_id: post_id,
					next: next_post_id,
					prev: prev_post_id
				}
			});
	});

	/********************Previous Modal **********************/

	$('.container').on('click','.modal-image .left', function() {
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(5, id.length));
	
		$('.img-modal').remove();
		$('.page-overlay').css("display", "none");
	
	
		var prev = $("#post-container-" + post_id).closest('.col-lg-4').prev('.col-lg-4').find('.profile-post-container');

		var prev_post_id;
		if (prev.length) {
			var prev_id = prev.attr('id');
			prev_post_id = parseInt(prev_id.substring(15, prev_id.length));
		} else {
			prev_post_id = -1;
		}

		var next = $("#post-container-" + post_id).closest('.col-lg-4').next('.col-lg-4').find('.profile-post-container');

		var next_post_id;
		if (next.length) {
			var next_id = next.attr('id');
			next_post_id = parseInt(next_id.substring(15, next_id.length));
		} else {
			next_post_id = -1;
		}

		$.ajax({
				url: '/post_modal',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'GET',
				data: {	
					authenticity_token: AUTH_TOKEN,
					post_id: post_id,
					next: next_post_id,
					prev: prev_post_id

				}
			});
	});


	/****************************** Right Modal ************************/

	$('.container').on('click','.modal-image .right', function() {
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(6, id.length));

		$('.img-modal').remove();
		$('.page-overlay').css("display", "none");

	
		var prev = $("#post-container-" + post_id).closest('.col-lg-4').prev('.col-lg-4').find('.profile-post-container');

		var prev_post_id;
		if (prev.length) {
			var prev_id = prev.attr('id');
			prev_post_id = parseInt(prev_id.substring(15, prev_id.length));
		} else {
			prev_post_id = -1;
		}

		var next = $("#post-container-" + post_id).closest('.col-lg-4').next('.col-lg-4').find('.profile-post-container');

		var next_post_id;
		if (next.length) {
			var next_id = next.attr('id');
			next_post_id = parseInt(next_id.substring(15, next_id.length));
		} else {
			next_post_id = -1;
		}

		$.ajax({
				url: '/post_modal',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'GET',
				data: {	
					authenticity_token: AUTH_TOKEN,
					post_id: post_id,
					next: next_post_id,
					prev: prev_post_id
				}
			});
	});



	/**************************** Like/Dislike Post ************************/

	$('.container').on('click', '.vote-call', function(e) {
		e.preventDefault();
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(5, id.length));

		$.ajax({
			url: '/vote',  // submits it to the given url of the form
			headers: {
				Accept: "text/javascript; charset=utf-8",
				"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			type: 'GET',
			data: {	
				authenticity_token: AUTH_TOKEN,
				post: post_id
			}
		});
	});



	/************************ Close Modal **************/

	$('body').on('click', '.modal-content', function(e) {
		e.stopPropagation();
	});

	$(document).on('click', function() {
		$('.img-modal').remove();
		$('.page-overlay').css("display", "none");
	});

	$('.container').on('click', '.modal-meta-top .close', function() {
		$('.img-modal').remove();
		$('.page-overlay').css("display", "none");
	});

	/****************************** Get More Comments *****************/
			
	var page = 2;
	$('.container').on('click', '.more-comments-link', function() {
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(14, id.length));
			
			$.ajax({
				type: "GET",
				url: "/get_modal_comments",
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				data: {
					post_id: post_id,
					page: page
				},
				success: function(data) {
					page = page + 1;
				}
			});
		});

	/************************* Submit comment on enter ******************/
	
	// This mimics an ajax submission form when user presses enter button
	// inside the comment text area.
	$('.container').on('keypress', '.comment-text-area', function(e) {
		if (e.which == 13 && !e.shiftKey) {
			$form = $(this).closest('form')[0];
			//var valuesToSubmit = $form.serialize;
			$.ajax({
				url: '/modal_comments',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'POST',
				data: {
					comment: {	
						content: $($form).find('textarea[name="content"]').val(), 
						profile_id: $($form).find('input[name="profile_id"]').val(), 
						post_id: $($form).find('input[name="post_id"]').val() 
					},
					authenticity_token: AUTH_TOKEN
				}
			});
		}
	});

});
