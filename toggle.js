//JB's klugey solution to what *may* be a conflict between Bootstrap and jQuery (and/or Isotope)
//because the data-toggle="buttons-radio" for Bootstrap was not working as expected
var toggle = function($btn, $group) {
	var parID = $group.attr('id');
	$('#' + parID + ' .btn').removeClass('active');
	if (parID !== "filters") {
		$btn.addClass('active');	
	}
	else {
		$('#filters button').each(function() {
			var button = $(this).attr('data-filter');
			if (button === "*") {
				button = "empty_string";
			}
			if (selectedTags.search(button) !== -1) {
				$(this).addClass('active');
			}
			if (selectedTags === "") {
				$('#show_all').addClass('active');
			}
		});
	}
};