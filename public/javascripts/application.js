// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function(){
  $("#customer_filter_region_id").change(function(){
    $.ajax({
      url: "details/" + $("#customer_filter_region_id").val(),
      success: function(data){ $("#details").html(data); },
      complete: function(){ 
        autocomplete_reporter();
        autocomplete_alternate();
        autocomplete_link();
        add_failure_dialog();
        set_button_behaviour();
      }

    });
    return false;
  });

  $('#catalogs_tab').hover(
    function(){
      $('#catalogs_children').css({top: $(this).parent().offset().top + 35, left: $(this).parent().offset().left});
      $('#catalogs_children').fadeIn();
      $('#dashboard').css({"margin-bottom": 45});
    },
    function(){
      $('#catalogs_children').fadeOut("slow");
      $('#dashboard').css({"margin-bottom": 15});
    }
  );
  
  $('#tickets_tab').hover(
    function(){
      $('#tickets_children').css({top: $(this).parent().offset().top + 35, left: $(this).parent().offset().left});
      $('#tickets_children').fadeIn();
      $('#dashboard').css({"margin-bottom": 45});
    },
    function(){
      $('#tickets_children').fadeOut("slow");
      $('#dashboard').css({"margin-bottom": 15});
    }
  );

  colorize_odd_rows();
  set_button_behaviour();

  $("#new_ticket").submitWithAjax();
});

// CUSTOM FUNCTIONS


function colorize_odd_rows() {
  $("tr:nth-child(odd)").addClass("odd");
}

function set_button_behaviour() {
  $(".ui-state-default").hover(
    function() { $(this).addClass('ui-state-hover'); },
    function() { $(this).removeClass('ui-state-hover'); }
  );
  $(".ui-state-default").css("cursor", "pointer");
}

// Failure dialog
function add_failure_dialog() {
  $('#add_failure').click(function() {
    $('#add_failure_dialog').dialog('open');
  });

  $("#add_failure_dialog").dialog({
    bgiframe: true,
    height: 280,
    modal: true,
    autoOpen: false,
    draggable: false,
    resizable: false
  });
}

// Autocompleters
function autocomplete_link(){
  $("input#sites").autocomplete("/tickets/auto_complete_for_link_sites",
  {mustMatch: true,
    extraParams: { 'options[region_id]': $("#customer_filter_region_id").val() }
  }); 
  $("input#sites").result(function(event, data, formatted) {
    var hidden = $("#ticket_link_id");
    hidden.val(data[1]);
    $.ajax({
      url: "/links/" + data[1],
      success: function(request) { $("div#link_details").html(request); set_button_behaviour();}
    });
  });
}

function autocomplete_reporter() {
  $("input#person_lastname_firstname").autocomplete("/tickets/auto_complete_for_person_lastname_firstname",
  { mustMatch: false,
    extraParams: { 'options[region_id]': $("#customer_filter_region_id").val(),
                   'select': "user.id company.name user.email"},
    formatItem: function(row) {
                  return row[0] + " " + 
                        "<span class='ac_company'>" + row[3] + "</span>" +
                        "<span class='ac_email'>" + row[4] + "</span>";
                }
  });
  $("input#person_lastname_firstname").result(function(event, data, formatted) {
    var hidden = $("#ticket_reported_by_id");
    hidden.val(data[2]);
    $.ajax({
      url: "/users/"+ data[2] +"?associated_field_id=person_lastname_firstname&value_tag_id=ticket_reported_by_id",
      success: function(request) { $("div#reporter_details").html(request); set_button_behaviour(); $("input#person_lastname_firstname").disable();}
    });
  });
}

function autocomplete_alternate() {
  $("input#alternate_person_lastname_firstname").autocomplete("/tickets/auto_complete_for_person_lastname_firstname",
  { mustMatch: false,
    extraParams: { 'options[region_id]': $("#customer_filter_region_id").val(),
                   'select': "user.id company.name user.email"},
    formatItem: function(row) {
                  return row[0] + " " + 
                        "<span class='ac_company'>" + row[3] + "</span>" +
                        "<span class='ac_email'>" + row[4] + "</span>";
                }
  });
  $("input#alternate_person_lastname_firstname").result(function(event, data, formatted) {
    var hidden = $("#ticket_alternate_contact_id");
    hidden.val(data[2]);
    $.ajax({
      url: "/users/"+ data[2] +"?associated_field_id=alternate_person_lastname_firstname&value_tag_id=ticket_alternate_contact_id",
      success: function(request) { $("div#alternate_details").html(request); set_button_behaviour(); $("input#alternate_person_lastname_firstname").disable();}
    });
  });
}

function show_progress() {
  $.blockUI({ 
    message: '<div id=\"progress\">',
    css: { border: 'none', backgroundColor: 'transparent' },
    baseZ: 1004});
  $('#progress').progressbar({value: 100});
}

function hide_progress() {
  $.unblockUI();
}
