$(document).ready(function() {
	
/***************Carousel************/
/*
	
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
*/

	$('.frame').flickity( {
		// options
		cellAlign: 'left',
		wrapAround: true
	});
});
