// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  $("#customer_filter_region_id").change(function(){
    $.ajax({
      url: "details/" + $("#customer_filter_region_id").val(),
      success: function(data){ $("#details").html(data); },
      complete: function(){ 
        autocomplete_reporter();
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

  colorize_odd_rows();
  set_button_behaviour();

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
  $("input#sites").autocomplete("auto_complete_for_link_sites",
  {mustMatch: true,
    extraParams: { 'options[region_id]': $("#customer_filter_region_id").val() },
  }); 
  $("input#sites").result(function(event, data, formatted) {
    var hidden = $("#ticket_link_id");
    hidden.val(data[1]);
    $.ajax({
      url: "/admin/links/show",
      data: {id: data[1]},
      success: function(request) { $("div#link_details").html(request); set_button_behaviour();}
    });
  });
}

function autocomplete_reporter() {
  $("input#person_lastname_firstname").autocomplete("auto_complete_for_person_lastname_firstname",
  { mustMatch: true,
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
      url: "/admin/users/"+ data[2],
      success: function(request) { $("div#reporter_details").html(request); set_button_behaviour();}
    });
  });
}
