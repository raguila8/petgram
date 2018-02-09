$(document).ready(function() {
	
/***************Carousel************/

	console.log($('.follow-btn-77'));

	
	$('.carousel[data-type="multi"] .item').each(function() {
		var next = $(this).next();
		if (!next.length) {
			next = $(this).siblings(':first');
		}
		next.children(':first-child').clone().appendTo($(this));

		for (var i=0;i<1;i++) {
    	next=next.next();
    	if (!next.length) {
    		next = $(this).siblings(':first');
  		}
    
    	next.children(':first-child').clone().appendTo($(this));
		}
	});

	/**************Follow and unfollow buttons **********/

	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

	/************************ Unfollow **************/
	$('.container').on('click', '.unfollow-btn', function() {

		var id = $(this).attr('id');
		var profile_id = parseInt(id.substring(14, id.length));
		console.log($('.card-actions').find('button'));
		console.log($('.card-actions').find('button#following-btn-79'));

		//$.each($('.card-actions').find('.following-btn-79'), function(k, v) {
		//	console.log($(this));
		//});
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
	$('.container').on('click', '.follow-btn', function() {
		console.log("clicked");
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
