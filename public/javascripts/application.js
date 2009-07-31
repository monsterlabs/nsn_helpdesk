// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  $("#customer_filter_region_id").change(function(){
    $.ajax({
      url: "details/" + $("#customer_filter_region_id").val(),
      success: function(data){ $("#details").html(data); },
      complete: function(){ 
        $("input#person_lastname_firstname").autocomplete("auto_complete_for_person_lastname_firstname",
        { mustMatch: true,
          extraParams: { 'options[region_id]': $("#customer_filter_region_id").val(),
                         'select': "company.name user.email"},
          formatItem: function(row) {
                        return row[0] + " " + 
                              "<span class='ac_company'>" + row[2] + "</span>" +
                              "<span class='ac_email'>" + row[3] + "</span>";
                      }
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

});

function colorize_odd_rows() {
  $("tr:nth-child(odd)").addClass("odd");
}
