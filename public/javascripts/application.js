// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){

	$("#filter_priority_id").change(function(){
		$.ajax({
		        url: "tickets/list_by_priority/" + $("#filter_priority_id").val(),
				success: function(data){ $("#ticket_collection").html(data); }
	    });
	    return false;
	 });
	
	$("#filter_status_id").change(function(){
		$.ajax({
		        url: "tickets/list_by_status/" + $("#filter_status_id").val(),
				success: function(data){ $("#ticket_collection").html(data); }
	    });
	    return false;
	 });
	
	$("#filter_region_id").change(function(){
		$.ajax({
		        url: "tickets/list_by_region/" + $("#filter_region_id").val(),
				success: function(data){ $("#ticket_collection").html(data); }
	    });
	    return false;
	 });
	
	$("#customer_filter_region_id").change(function(){
		$.ajax({
		        url: "tickets/list_by_region/" + $("#customer_filter_region_id").val(),
				success: function(data){ $("#ticket_collection").html(data); }
	    });
	    return false;
	 });
	
});
