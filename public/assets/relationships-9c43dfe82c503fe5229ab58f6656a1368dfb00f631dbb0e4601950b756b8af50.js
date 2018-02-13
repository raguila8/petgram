$(document).ready( function() {
	/**************Follow and unfollow buttons **********/

	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

	/************************ Unfollow **************/
	$('body').on('click', '.unfollow-btn', function(event) {
	  event.stopImmediatePropagation();
		var id = $(this).attr('id');
		var profile_id = parseInt(id.substring(14, id.length));
		$(".following-btn-" + profile_id).remove();
		
		$.ajax({
			url: '/unfollow',  // submits it to the given url of the form
			headers: {
				Accept: "text/javascript; charset=utf-8",					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			type: 'GET',
			data: {	
				authenticity_token: AUTH_TOKEN,
				followed: profile_id
			}
		});
	});

	/****************************** Follow *****************/
	$('body').on('click', '.follow-btn', function(event) {
		event.stopImmediatePropagation();
		var id = $(this).attr('id');
		var profile_id = parseInt(id.substring(11, id.length));
		$(".follow-btn-" + profile_id).remove();
		$.ajax({
			url: '/follow',  // submits it to the given url of the form
			headers: {
				Accept: "text/javascript; charset=utf-8",					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			type: 'POST',
			data: {	
				authenticity_token: AUTH_TOKEN,
				followed: profile_id
			}
		});
	});

});
