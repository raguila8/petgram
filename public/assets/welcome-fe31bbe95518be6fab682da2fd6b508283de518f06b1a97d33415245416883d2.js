$(document).ready(function() {
	$('.select_profile_image_container img').on('click', function() {
		$('.select_profile_image_preview img').attr("src", $(this).attr('src'));
		$form = $('#profile_image_input');
		$($form).val($(this).attr('src'))
	});

	
});
