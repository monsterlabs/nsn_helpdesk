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
		        url: "details/" + $("#customer_filter_region_id").val(),
						success: function(data){ $("#details").html(data); },
						complete: function(){ 
								$("input#person_lastname_firstname").autocomplete("auto_complete_for_person_lastname_firstname",
								{ mustMatch: true,
								 extraParams: { 'options[region_id]': $("#customer_filter_region_id").val() },
								});
								$("input#person_lastname_firstname").result(function(event, data, formatted) {
										var hidden = $("#ticket_reported_by_id");
										hidden.val(data[1]);
								});
								$("input#link_sites").autocomplete("auto_complete_for_link_sites",
								{mustMatch: true,
								 extraParams: { 'options[region_id]': $("#customer_filter_region_id").val() },
								 }); 
								$("input#link_sites").result(function(event, data, formatted) {
										var hidden = $("#ticket_link_id");
										hidden.val(data[1]);
								});
								
								}
								
	    });
	    return false;
	 });
	 
     $('#timer').epiclock({mode: EC_COUNTUP, target: $("#ticket_opened_at").val()}); 
     $('#timer').clocks(EC_RUN);
});
