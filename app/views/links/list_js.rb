class Views::Links::ListJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Links::Record, :collection => @collection
    jquery "$('#paginator').remove();"
    #paginator(@collection)
    #jquery "$('#links_collection').append('Paginator');"
  end
end