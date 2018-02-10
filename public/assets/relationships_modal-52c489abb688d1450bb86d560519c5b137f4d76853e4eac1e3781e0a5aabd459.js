$(document).ready(function() {
	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');


	/******************* open followers modal **************/

	$('.followers-modal-toggle').on('click', function() {
		var id = $(this).attr('id');
		var profile_id = parseInt(id.substring(10, id.length));
		
		$.ajax({
				url: '/followers_modal',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'GET',
				data: {	
					authenticity_token: AUTH_TOKEN,
					profile_id: profile_id
				}
			});
	});

	
	/************************ Open following modal **********/

	$('.following-modal-toggle').on('click', function() {
		var id = $(this).attr('id');
		var profile_id = parseInt(id.substring(10, id.length));
		
		$.ajax({
				url: '/following_modal',  // submits it to the given url of the form
				headers: {
					Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				type: 'GET',
				data: {	
					authenticity_token: AUTH_TOKEN,
					profile_id: profile_id
				}
			});
	});


	/************************ Close Modal **************/

	$('body').on('click', '.modal-content', function(e) {
		e.stopPropagation();
	});

	$(document).on('click', function() {
		$('.followers-modal').remove();
		$('.following-modal').remove();
		$('.page-overlay').css("display", "none");
	});

	$('.container').on('click', '.modal-meta-top .close', function() {
		$('.img-modal').remove();
		$('.page-overlay').css("display", "none");
	});



});
