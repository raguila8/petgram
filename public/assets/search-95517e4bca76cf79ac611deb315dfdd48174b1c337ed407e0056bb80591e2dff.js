$(document).on('turbolinks:load', function() {
	if ($('#main-search').length) {
			
	$('#main-search').autocomplete({
		source: function( request, response ) {
			$.ajax({
				type: "GET",
				url: "/autocomplete",
				data: {
					query: request.term
				},
				success: function(data) {
					
					response(data.suggestions);
					console.log(data.suggestions);
				}
			});
		},
		select: function(event, ui) {
			event.preventDefault();
			$("#main-search").val(ui.item.username);
			window.location.href = "/profiles/" + ui.item.id;
			
		},
		focus: function(event, ui) {
			event.preventDefault();
			$('#main-search').val(ui.item.username);
		},
		minLength: 1
	}).autocomplete("instance")._renderItem = function( ul, item ) {
		return $("<a id='profile-result-" + item.id + "' href='/profiles/" + item.id + "'><li class='profile-item'><div class='ac-item-container'>" +
							"<div class='small-thumb-container'><img class='small-thumb' style='width: 30px; height: 30px;' src='/profile_default.png'></div>" + 
						"<div class='item-info'><p class='username-item'>" + item.username + "</p><span class='name-item'>" + item.name + 
							"</span></div></li></div></a>").appendTo( ul );

	}
});
