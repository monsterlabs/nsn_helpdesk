class Views::Links::Index < Views::Layouts::Application

  jquery <<-JS
    $("tr#filter_row select").change(function() {
      $.ajax({
        complete:function(request){colorize_odd_rows()}, 
        data:$.param($("form").serializeArray()),
        success:function(request){$('#links').html(request);},
        type:'post', 
        url:'links/filter'}); 
        return false; });
  JS

  def page_title
    "Links Index"
  end

  def view_content
      span :id =>"links_collection", :class => 'collection' do
        widget Views::Links::Table, :collection => @collection
        paginator(@collection)
      end
      
      rawtext link_to 'Add link', {:action => 'new'}, ui_style(:button)    
  end
end
