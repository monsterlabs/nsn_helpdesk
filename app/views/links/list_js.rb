class Views::Links::ListJs < Views::Layouts::ApplicationJs
  def js_content
    jquery <<-JS
      $("tr#filter_row select").change(function() {
        $.ajax({
          complete:function(request){colorize_odd_rows()}, 
          data:$.param($("form").serializeArray()),
          success:function(request){$('#links_collection').html(request);},
          type:'post', 
          url:'links/filter'}); 
          return false; });
    JS
    widget Views::Links::Table, :collection => @collection
    paginator(@collection, 'index')
  end
end