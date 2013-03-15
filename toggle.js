//JB's klugey solution to what *may* be a conflict between Bootstrap and jQuery (and/or Isotope)
//because the data-toggle="buttons-radio" for Bootstrap was not working as expected
var toggle = function($btn, $group) {
	var parID = $group.attr('id');
	$('#' + parID + ' .btn').removeClass('active');
	$btn.addClass('active');
};