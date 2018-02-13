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
		minLength: 1
	}).autocomplete("instance")._renderItem = function( ul, item ) {
		return $("<a href='/profiles/" + item.id + "'><li class='profile-item'><div class='ac-item-container'>" +
							"<div class='small-thumb-container'><img class='small-thumb' style='width: 30px; height: 30px;' src='/profile_default.png'></div>" + 
						"<div class='item-info'><p class='username-item'>" + item.username + "</p><span class='name-item'>" + item.name + 
							"</span></div></li></div></a>").appendTo( ul );

			/*return $( "<li class=\"profile-item\">" + "<img style=\"width: 30px; height: 30px;\" src=\"/profile_default.png\", class=\"small-thumb\">" +  "<div class=\"item-info\"><span class=\"username-item\">" + item.username + "</span><br><span class=\"name-item\">" + item.name + "</span></div></li>" ).appendTo( ul );
*/		
	};
	}
});
