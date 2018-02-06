$(document).on('turbolinks:load', function() {
	/*$(".profile-followers").on('click', function() {
		$(".followers-modal").addClass("modal-active");
		$(".modal_overlay").addClass("modal_overlay_active");
	});

	$(".profile-following").on('click', function() {
		$(".following-modal").addClass("modal-active");
		$(".modal_overlay").addClass("modal_overlay_active");
	});

	$(".modal_overlay").on("click", function() {
		$(".modal_overlay").removeClass("modal_overlay_active");
		$(".followers-modal").removeClass("modal-active");
		$(".following-modal").removeClass("modal-active");
	});*/

	/******************************* Image Preview ***************/


	var preview = $(".upload-preview img");

	// Previews the image when user selects img file to submit
  $(".img-file").change(function(event){
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();
    reader.onload = function(e){
        image_base64 = e.target.result;
        preview.attr("src", image_base64);	
    };
    reader.readAsDataURL(file);
		$('.img-responsive100').css({"border" : "4px solid #808080" });
	});

	
});
