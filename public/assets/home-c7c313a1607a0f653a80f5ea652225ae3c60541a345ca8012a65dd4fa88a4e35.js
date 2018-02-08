$(document).ready(function() {

	/********************* Comments Form *****************/

	$('.glyphicon-comment').on('click', function() {
		$($(this).parent().parent().last()).find('textarea[name="comment[content]"]').focus();
	});

	// Need token for ajax call
	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
	
	// This mimics an ajax submission form when user presses enter button
	// inside the comment text area.
	$('.feed-body').on('keypress', '.comment-text-area', function(e) {
		if (e.which == 13 && !e.shiftKey) {
			$form = $(this).closest('form')[0];
			//var valuesToSubmit = $form.serialize;
			$.ajax({
				url: '/comments',  // submits it to the given url of the form
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
		var numberOfPosts = $('.feed-img').length;
		var postPages = new Array();
		for (var i = 0; i < numberOfPosts; i++) {
			postPages[i] = 2;
		}
		$('.feed-body').on('click', '.more-comments-link', function() {
			var id = $(this).attr('id');
			var post_id = parseInt(id.substring(14, id.length));
			var post_number_str = $($(this).closest('.post-container')).attr('id');
			var post_number = post_number_str.substring(11, post_number_str.length);
			
			$.ajax({
				type: "GET",
				url: "/get_comments",
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				data: {
					post_id: post_id,
					page: postPages[post_number]
				},
				success: function(data) {
					postPages[post_number] = postPages[post_number] + 1;
				}
			});
		});


	
	/************************** Load more Posts ******************/

	var currentPostPage = 2;
	var didScroll = false;
	function loadMorePosts() {
		if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
		$.ajax({
			type: "GET",
			url: "/home",
			headers: {
				Accept: "text/javascript; charset=utf-8",
				"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			data: {
				page: currentPostPage
			},
			success: function(myData) {
				currentPostPage = currentPostPage + 1;
				for (var i = 0; i < 2; i++) {
					postPages.push(2);
				}
			}
		});
		}
	}

	function throttle(loadMorePosts, wait) {
		var time = Date.now();
		return function() {
			if ((time + wait - Date.now()) < 0) {
				loadMorePosts();
				time = Date.now();
			}
		}
	}
	if ($('.feed-body').length) {
		$(window).on('scroll', throttle(loadMorePosts, 1000));
	}
});
