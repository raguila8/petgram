$(document).ready(function() {
			
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
	});
});
