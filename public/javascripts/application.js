// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs

$(document).ready(function() {

	$('.delete_alert').bind('ajax:success', function() {
		$(this).closest('tr').fadeOut();
	});
});

#$(document).ready(function() {
#
#	$('.delete_alert').bind('ajax:success', function() {
#    		document.getElementById('td1').innerHTML = "Some text to enter";
#	});
#});
