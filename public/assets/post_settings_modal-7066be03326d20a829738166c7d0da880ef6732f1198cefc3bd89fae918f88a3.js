$(document).ready(function() {

	/************************ Open modal ***************************/

	var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
	
	$('body').on('click', 'span.glyphicon-cog', function() {
		
		var id = $(this).attr('id');
		var post_id = parseInt(id.substring(14, id.length));
	
		$.ajax({
			url: '/post_settings_modal',  // submits it to the given url of the form
			headers: {
				Accept: "text/javascript; charset=utf-8",
					"Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
			},
			type: 'GET',
			data: {	
				authenticity_token: AUTH_TOKEN,
				post_id: post_id
			}
		});
	});

	/************************ Close Modal **************/

	$('body').on('click', '.modal-content', function(e) {
		e.stopPropagation();
	});

	$(document).on('click', function() {
		$('.post-settings-modal').remove();
		$('.page-overlay').css("display", "none");
	});

});
