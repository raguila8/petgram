$(document).ready(function() {

	/******************************* get comments ************/
		var numberOfPosts = $('.feed-img').length;
		var postPages = new Array();
		for (var i = 0; i < numberOfPosts; i++) {
			postPages[i] = 2;
		}
		$('.more-comments-link').on('click', function() {
			console.log("clicked");
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
		console.log("hello");
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
				console.log(currentPostPage);
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
		$(window).on('scroll', throttle(loadMorePosts, 500));
	}
});
