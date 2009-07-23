class Views::Layouts::Page < Erector::RailsWidget
  # Array of javascript files
  @@js = []  
  def self.js(*files)
    files.each {|f| @@js << f unless @@js.include?(f) }
  end

  # Array of css files
  @@css = []
  def self.css(*files)
    files.each {|f| @@css << f unless @@css.include?(f) }
  end

  # Inline css code
  @@styles = []
  def self.style(txt)
    @@styles << txt
  end

  # Inline javascript code
  @@scripts = []
  def self.script(txt)
    @@scripts << txt
  end

  @@jqueries = []
  def self.jquery(txt)
    @@jqueries << txt
  end

  def doctype
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
  end

  # override me in a view
  def page_title
    "page"
  end

  # override me in a layout
  def body_content
    text "No action rendered"
  end

  def content
    rawtext doctype
    html :xmlns => 'http://www.w3.org/1999/xhtml', 'xml:lang' => 'en', :lang => 'en' do
      head { head_content }
      body do
        body_content
      end
    end
  end

  def head_content
    meta 'http-equiv' => 'content-type', :content => 'text/html;charset=UTF-8'
    title page_title
    @@js.each do |file|
      javascript_include_tag file
    end
    @@css.each do |file|
      stylesheet_link_tag file
    end
    inline_styles
    inline_scripts
  end

  def inline_styles
    style :type=>"text/css", 'xml:space' => 'preserve' do
      rawtext "\n"
      @@styles.each do |txt|
        rawtext "\n"
        rawtext txt
      end
    end
  end
  
  def inline_scripts
    javascript do
      @@scripts.each do |txt|
        rawtext "\n"
        rawtext txt
      end
      @@jqueries.each do |txt|
        rawtext "\n"
        rawtext "$(document).ready(function(){\n"
        rawtext txt
        rawtext "\n});"
      end
    end
  end
  def request
    @controller.request
  end
end

class Erector::Widget
  prettyprint_default = true
  
  def jquery(txt)
    javascript do
      rawtext "\n"
      rawtext "$(document).ready(function(){\n"
      rawtext txt
      rawtext "\n});"
    end
  end
  
  def dom_id(record, prefix = nil)
    if (record.id.nil?)
      return "#{prefix}new_#{record.class.name.downcase}"
    else
      return "#{record.class.name.downcase}_#{record.id}"
    end
  end
  
  # ui_style(:button, {:id => "login_button"})
  # => "class='ui-state-default ui-corner-all button' id='login_button'"
  def ui_style(*styles)
    classes = []
    ids =[]
    styles.each do |style|
      case style
      when :button
        classes << ["ui-state-default", "ui-corner-all", "button"]
      when Hash
        ids << style[:id]
        classes << style[:class]
      end
    end
    return {:class => classes.flatten.join(" "), :id => ids.flatten.join(" ")}
  end

  def paginator(collection)
    div :class => "paginator", :id => "paginator" do
      if collection.total_pages > 1
        (1..collection.total_pages).collect do |page|
          previous_page(collection, page)
          current_page(collection, page)
          next_page(collection, page)
        end
      end
    end
  end
  
  def previous_page(collection, page)
      link_to_page 'Previous', collection.previous_page if !collection.previous_page.nil? and page == 1
  end
  
  def current_page(collection, page)
    if page == collection.current_page
      rawtext content_tag(:span, page, :class => 'current')
    else
      link_to_page page, page unless page == collection.current_page
    end
  end
  
  def next_page(collection, page)
      link_to_page 'Next',  collection.next_page if !collection.next_page.nil? and page == collection.total_pages
  end
  
  def link_to_page(label, page)
      link_to label, :action => :index, :page => page
  end
  
  def table_header(columns)
      thead :class => "ui-widget-header", :id => "listing-head" do
        tr do
            columns.each  do |column|
              th { text column }
            end
      end
    end
  end
  
  def filter_select(class_name, dom_id = "filter")
    collection_select(dom_id, classify(class_name).foreign_key, classify(class_name).constantize.all, :id, :name, {:prompt => true})
  end

  def simple_select(object, class_name, method_name=nil,options={})
    method_name ||= classify(class_name).foreign_key 
    collection_select(object, method_name, classify(class_name).constantize.all, :id, :name, options)
  end

  def classify(class_name)
     ActiveSupport::Inflector.tableize(class_name).classify
  end
  
end

class Erector::RailsWidget
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::DateHelper
  include WillPaginate::ViewHelpers
  include ActionView::Helpers::FormOptionsHelper
end
